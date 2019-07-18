#include <time.h>
#include <stdlib.h>

#include <QtCore/qabstractanimation.h>
#include <QtCore/qdir.h>
#include <QtCore/qmath.h>
#include <QtCore/qdatetime.h>
#include <QtCore/qpointer.h>
#include <QtCore/qscopedpointer.h>
#include <QtCore/qtextstream.h>

#include <QtGui/QGuiApplication>

#include <QtQml/qqml.h>
#include <QtQml/qqmlengine.h>
#include <QtQml/qqmlcomponent.h>
#include <QtQml/qqmlcontext.h>

#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#include <QtWidgets/QApplication>
#include <QtWidgets/QFileDialog>

#include <QtCore/QTranslator>
#include <QtCore/QLibraryInfo>

#include <QThread>
#include <QFileSystemWatcher>

#include <QStringList>
#include <QDir>
#include <QString>
#include <QObject>
#include <QFileInfo>
#include <QResource>
#include <QProcess>

#include <src/oscursor.h>
#include <src/livereload.h>
#include <src/mocks/Wallet.h>
#include <src/mocks/NetworkType.h>
#include <src/utils.h>
#include <src/mocks/QrcMock.h>
#include <src/mocks/clipboard.h>


//#define USE_ApplicationEngine

#ifdef USE_ApplicationEngine
	#include <QQmlApplicationEngine>
#endif


int main(int argc, char **argv)
{
    QString lol = QString("/Users/dsc/ClionProjects/monero-gui/qml.qrc");

    int exitCode = 0;
    srand(time(NULL));

    StartOptions options;
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts, options.contextSharing);  // QtWebEngine needs a shared context in order for the GPU thread to upload textures.

    QGuiApplication app(argc, argv);
    app.setApplicationName("QmlLive");
    app.setOrganizationName("QtProject");
    app.setOrganizationDomain("qt-project.org");

    QStringList imports;
    QStringList pluginPaths;
    for (int i = 1; i < argc; ++i) {
        if (*argv[i] != '-' && QFileInfo(QFile::decodeName(argv[i])).exists()) {
            options.file = QUrl::fromLocalFile(argv[i]);
            if(!options.file.isEmpty())
                options.fileInfo = QFileInfo(argv[1]);
        } else {
            const QString lowerArgument = QString::fromLatin1(argv[i]).toLower();
            if (lowerArgument == QLatin1String("--maximized"))
                options.maximized = true;
            else if (lowerArgument == QLatin1String("--fullscreen"))
                options.fullscreen = true;
            else if (lowerArgument == QLatin1String("--transparent"))
                options.transparent = true;
            else if (lowerArgument == QLatin1String("--clip"))
                options.clip = true;
            else if (lowerArgument == QLatin1String("--no-version-detection"))
                options.versionDetection = false;
            else if (lowerArgument == QLatin1String("--slow-animations"))
                options.slowAnimations = true;
            else if (lowerArgument == QLatin1String("--quit"))
                options.quitImmediately = true;
            else if (lowerArgument == QLatin1String("-translation"))
                options.translationFile = QLatin1String(argv[++i]);
            else if (lowerArgument == QLatin1String("--resize-to-root"))
                options.resizeViewToRootItem = true;
            else if (lowerArgument == QLatin1String("--multisample"))
                options.multisample = true;
            else if (lowerArgument == QLatin1String("--disable-context-sharing"))
                options.contextSharing = false;
            else if (lowerArgument == QLatin1String("-i") && i + 1 < argc)
                imports.append(QString::fromLatin1(argv[++i]));
            else if (lowerArgument == QLatin1String("-p") && i + 1 < argc)
                pluginPaths.append(QString::fromLatin1(argv[++i]));
            else if (lowerArgument == QLatin1String("--help")
                     || lowerArgument == QLatin1String("-help")
                     || lowerArgument == QLatin1String("--h")
                     || lowerArgument == QLatin1String("-h"))
                usage();
        }
    }

    // validate incoming QML filename
    if(options.file.isEmpty()){
        usage();
        return 0;
    }

    QString path_abs = options.fileInfo.absolutePath();
    QString path_qml_qrc = path_abs + QString("/%1").arg("qml.qrc");

	// bootstrap qml.qrc
	if(!fileExists(path_qml_qrc)){
		printErr(QString("Cannot find qml.qrc file, images will be missing. Tried: %1.").arg(path_qml_qrc));
	} else {
        QrcMock qmlQrcMock;
        if(qmlQrcMock.load(path_qml_qrc)){
            if(qmlQrcMock.compile()){
                qmlQrcMock.install();
            };
        }
	}

	if (!options.file.isEmpty()) {
		if (!options.versionDetection || checkVersion(options.file)) {
#ifndef QT_NO_TRANSLATION
			QTranslator translator;
#endif

			// TODO: as soon as the engine construction completes, the debug service is listening for connections.  But actually we aren't ready to debug anything.
			QQmlEngine engine;
			OSCursor cursor;

            engine.addImportPath(":/fonts");
			engine.rootContext()->setContextProperty("globalCursor", &cursor);
			engine.rootContext()->setContextProperty("qt_version_str", QT_VERSION_STR);

            qmlRegisterUncreatableType<Wallet>("moneroComponents.Wallet", 1, 0, "Wallet", "Wallet can't be instantiated directly");
            qmlRegisterType<clipboardAdapter>("moneroComponents.Clipboard", 1, 0, "Clipboard");
            qmlRegisterType<NetworkType>("moneroComponents.NetworkType", 1, 0, "NetworkType");

			for (int i = 0; i < imports.size(); ++i)
				engine.addImportPath(imports.at(i));
			for (int i = 0; i < pluginPaths.size(); ++i)
				engine.addPluginPath(pluginPaths.at(i));
			if (options.file.isLocalFile()) {
				QFileInfo fi(options.file.toLocalFile());
#ifndef QT_NO_TRANSLATION
				loadTranslationFile(translator, fi.path());
#endif
				loadDummyDataFiles(engine, fi.path());
			}
			QObject::connect(&engine, SIGNAL(quit()), QCoreApplication::instance(), SLOT(quit()));

			QPointer<QQmlComponent> component = new QQmlComponent(&engine);
			component->loadUrl(options.file);

			QQuickView* qxView = new QQuickView(&engine, NULL);
			LiveReload liver(&engine, qxView, component, options);
			if (options.quitImmediately)
				QMetaObject::invokeMethod(QCoreApplication::instance(), "quit", Qt::QueuedConnection);

			// Now would be a good time to inform the debug service to start listening.

			exitCode = app.exec();

#ifdef QML_RUNTIME_TESTING
			RenderStatistics::printTotalStats();
#endif
			// Ready to exit. Notice that the component might be owned by
			// QQuickView if one was created. That case is tracked by
			// QPointer, so it is safe to delete the component here.
			delete component;
		}
	}

	return exitCode;
}


/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the tools applications of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** As a special exception, The Qt Company gives you certain additional
** rights. These rights are described in The Qt Company LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/
