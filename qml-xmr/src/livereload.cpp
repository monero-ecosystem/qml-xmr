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
#include <QObject>

#include <src/oscursor.h>
#include <src/utils.h>
#include <src/livereload.h>
#include <src/window.h>
#include "livereload.moc"


LiveReload::LiveReload(QQmlEngine * a_engine_handler
        , QQuickView* a_qxView, QPointer<QQmlComponent> a_component
        , StartOptions a_options
)
        :QObject(){

    engine_handler = a_engine_handler;
    qxView = a_qxView;
    component = a_component;
    options = a_options;
//#ifdef USE_ApplicationEngine
//	engine_handler = qobject_cast<QQmlApplicationEngine *>(createWindow(engine_handler, qxView, component, options));
//#else
    window = createWindow(engine_handler, qxView, component, options);
//#endif
//
    QFileInfo file(options.file.toLocalFile());
    QStringList list;
    list << file.path();
    QStringList *dirList;
    dirList = &list;
    this->subFoldersList(file.path(), dirList);
    watcher.addPaths(*dirList);

    connect(&watcher, SIGNAL(directoryChanged(const QString &)),
    this, SLOT(fileChanged(const QString &)));
    connect(&watcher, SIGNAL(fileChanged(const QString &)),
    this, SLOT(fileChanged(const QString &)));
}