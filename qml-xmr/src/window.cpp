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

#include <src/utils.h>


QQuickWindow * createWindow(QQmlEngine *engine_handler,
                            QQuickView *qxView, QPointer<QQmlComponent> component,
                            StartOptions options,
                            QQuickWindow *window = NULL) {

    if ( !component->isReady() ) {
        fprintf(stderr, "QML Error %s\n%s\n",
                qPrintable(randomTableFlip()),
                qPrintable(component->errorString()));
        exit(0);
    }

    QObject *topLevel = component->create();
    if (!topLevel && component->isError()) {
        fprintf(stderr, "Error:\n%s\n", qPrintable(component->errorString()));
        exit(0);
    }

    QQuickWindow *r_window;

    //Oh scoped pointer
//	QScopedPointer<QQuickWindow> window(qobject_cast<QQuickWindow *>(topLevel));
//	if (NULL == window) window = qobject_cast<QQuickWindow *>(topLevel);
    if (window) {
        window->close();
    };
    window = qobject_cast<QQuickWindow *>(topLevel);
    r_window = window;
    qDebug() << r_window << window;

    if (window) {
#ifdef USE_ApplicationEngine
        delete(window);
		engine_handler = new QQmlApplicationEngine();
		qobject_cast<QQmlApplicationEngine *>(engine_handler)->load(options.file);
		qobject_cast<QQuickWindow *>(qobject_cast<QQmlApplicationEngine *>(engine_handler)->rootObjects().value(0))->show();
		return engine_handler;
#else
        engine_handler->setIncubationController(window->incubationController());
#endif
    } else {
        QQuickItem *contentItem = qobject_cast<QQuickItem *>(topLevel);
        if (contentItem) {
            //QQuickView* qxView = new QQuickView(&engine, NULL);
//			window.reset(qxView);
            window = qobject_cast<QQuickWindow *>(qxView);
            // Set window default properties; the qml can still override them
            QString oname = contentItem->objectName();
            window->setTitle(oname.isEmpty() ? QString::fromLatin1("QmlLive") : QString::fromLatin1("QmlLive: ") + oname);
            if (options.resizeViewToRootItem)
                qxView->setResizeMode(QQuickView::SizeViewToRootObject);
            else
                qxView->setResizeMode(QQuickView::SizeRootObjectToView);
            qxView->setSource(QUrl());
            qxView->setContent(options.file, component, contentItem);
        }
    }

    if (window) {
        QSurfaceFormat surfaceFormat = window->requestedFormat();
        if (options.multisample)
            surfaceFormat.setSamples(16);
        if (options.transparent) {
            surfaceFormat.setAlphaBufferSize(8);
            window->setClearBeforeRendering(true);
            window->setColor(QColor(Qt::transparent));
            window->setFlags(Qt::FramelessWindowHint);
        }
        window->setFormat(surfaceFormat);

        if (window->flags() == Qt::Window) // Fix window flags unless set by QML.
            window->setFlags(Qt::Window | Qt::WindowSystemMenuHint | Qt::WindowTitleHint | Qt::WindowMinMaxButtonsHint | Qt::WindowCloseButtonHint | Qt::WindowFullscreenButtonHint);

        if (options.fullscreen)
            window->showFullScreen();
        else if (options.maximized)
            window->showMaximized();
        else if (!window->isVisible())
            window->show();
    }

    return r_window;
}