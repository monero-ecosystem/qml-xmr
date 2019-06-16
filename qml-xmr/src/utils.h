#ifndef UTILS_H
#define UTILS_H

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
#include <src/oscursor.h>


struct StartOptions
{
    StartOptions() : originalQml(false),
        originalQmlRaster(false),
        maximized(false),
        fullscreen(false),
        transparent(false),
        clip(false),
        versionDetection(true),
        slowAnimations(false),
        quitImmediately(false),
        resizeViewToRootItem(false),
        multisample(false),
        contextSharing(true) { }

    QUrl file;
    QFileInfo fileInfo;
    bool originalQml;
    bool originalQmlRaster;
    bool maximized;
    bool fullscreen;
    bool transparent;
    bool clip;
    bool versionDetection;
    bool slowAnimations;
    bool quitImmediately;
    bool resizeViewToRootItem;
    bool multisample;
    bool contextSharing;
    QString translationFile;
};


#ifdef QML_RUNTIME_TESTING
class RenderStatistics;
QVector<qreal> RenderStatistics::timePerFrame;
QVector<int> RenderStatistics::timesPerFrames;
void RenderStatistics::updateStats();
void RenderStatistics::printTotalStats();
#endif

#if defined(QMLSCENE_BUNDLE)
QFileInfoList findQmlFiles(const QString &dirName);
static int displayOptionsDialog(Options *options);
#endif

bool checkVersion(const QUrl &url);

#ifndef QT_NO_TRANSLATION
void loadTranslationFile(QTranslator &translator, const QString& directory);
#endif

void loadDummyDataFiles(QQmlEngine &engine, const QString& directory);
QString randomTableFlip();

void usage();
bool writeFile(const QString &path, const QString &data);
bool writeFile(const QString &path, const QByteArray &data);
bool fileExists(QString path);
QString readFile(const QString &path);
QString qrcFilter(const QString &path);
void printErr(QString msg);
void printOut(QString msg);

#endif
