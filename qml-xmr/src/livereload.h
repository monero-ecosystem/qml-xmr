#ifndef QML_XMR_LIVERELOAD
#define QML_XMR_LIVERELOAD

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
#include <QFileInfo>

#include <src/utils.h>
#include <src/window.h>
#include <src/oscursor.h>


class LiveReload: public QObject{
Q_OBJECT
public:
    LiveReload(QQmlEngine * engine_handler
            , QQuickView* qxView, QPointer<QQmlComponent> component
            , StartOptions options
    );
private:
    QFileSystemWatcher watcher;
    QQmlEngine *engine_handler;
    QQuickView* qxView;
    QPointer<QQmlComponent> component;
    StartOptions options;
    QQuickWindow * window;

    void subFoldersList(QString folder, QStringList *dirList)
    {
        QDir dir(folder);
        dir.setFilter(QDir::Dirs);

        QFileInfoList list = dir.entryInfoList();

        for(int i = 0; i < list.size(); ++i) {
            QFileInfo fileInfo = list.at(i);
            if (fileInfo.fileName() != "." && fileInfo.fileName() != "..") {
                QString folderPath = fileInfo.path() + "/" + fileInfo.fileName();
                *dirList << folderPath;
                subFoldersList(folderPath, dirList);
            }
        }
    }

private slots:
    void fileChanged(const QString & path) {
        qDebug() << "file changed: " << path;

        engine_handler->clearComponentCache();
        QThread::msleep(50);
#ifdef USE_ApplicationEngine
        qobject_cast<QQmlApplicationEngine *>(engine_handler)->load(options.file);
		qobject_cast<QQuickWindow *>(qobject_cast<QQmlApplicationEngine *>(engine_handler)->rootObjects().value(0))->show();
#else
        component = new QQmlComponent(engine_handler);
        component->loadUrl(options.file);
        window = createWindow(engine_handler, qxView, component, options, window);
#endif
    }
};

#endif
