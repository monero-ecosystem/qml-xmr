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

#include <QRegularExpressionMatch>
#include <QStringList>
#include <QDir>
#include <QString>
#include <QFileInfo>

#include <src/utils.h>
#include <src/oscursor.h>


#if defined(QMLSCENE_BUNDLE)
QFileInfoList findQmlFiles(const QString &dirName)
{
	QDir dir(dirName);

	QFileInfoList ret;
	if (dir.exists()) {
		QFileInfoList fileInfos = dir.entryInfoList(QStringList() << "*.qml",
													QDir::Files | QDir::AllDirs | QDir::NoDotAndDotDot);

		foreach (QFileInfo fileInfo, fileInfos) {
			if (fileInfo.isDir())
				ret += findQmlFiles(fileInfo.filePath());
			else if (fileInfo.fileName().length() > 0 && fileInfo.fileName().at(0).isLower())
				ret.append(fileInfo);
		}
	}

	return ret;
}

#endif

bool checkVersion(const QUrl &url)
{
    if (!qgetenv("QMLSCENE_IMPORT_NAME").isEmpty())
        fprintf(stderr, "QMLSCENE_IMPORT_NAME is no longer supported.\n");

    QString fileName = url.toLocalFile();
    if (fileName.isEmpty()) {
        fprintf(stderr, "qmlscene: filename required.\n");
        return false;
    }

    QFile f(fileName);
    if (!f.open(QFile::ReadOnly | QFile::Text)) {
        fprintf(stderr, "qmlscene: failed to check version of file '%s', could not open...\n",
                qPrintable(fileName));
        return false;
    }

    QRegExp quick1("^\\s*import +QtQuick +1\\.\\w*");
    QRegExp qt47("^\\s*import +Qt +4\\.7");

    QTextStream stream(&f);
    bool codeFound= false;
    while (!codeFound) {
        QString line = stream.readLine();
        if (line.contains("{")) {
            codeFound = true;
        } else {
            QString import;
            if (quick1.indexIn(line) >= 0)
                import = quick1.cap(0).trimmed();
            else if (qt47.indexIn(line) >= 0)
                import = qt47.cap(0).trimmed();

            if (!import.isNull()) {
                fprintf(stderr, "qmlscene: '%s' is no longer supported.\n"
                                "Use qmlviewer to load file '%s'.\n",
                        qPrintable(import),
                        qPrintable(fileName));
                return false;
            }
        }
    }

    return true;
}

#ifndef QT_NO_TRANSLATION
void loadTranslationFile(QTranslator &translator, const QString& directory)
{
    translator.load(QLatin1String("qml_" )+QLocale::system().name(), directory + QLatin1String("/i18n"));
    QCoreApplication::installTranslator(&translator);
}
#endif

void loadDummyDataFiles(QQmlEngine &engine, const QString& directory)
{
    QDir dir(directory+"/dummydata", "*.qml");
    QStringList list = dir.entryList();
    for (int i = 0; i < list.size(); ++i) {
        QString qml = list.at(i);
        QQmlComponent comp(&engine, dir.filePath(qml));
        QObject *dummyData = comp.create();

        if(comp.isError()) {
            QList<QQmlError> errors = comp.errors();
            foreach (const QQmlError &error, errors)
            fprintf(stderr, "%s\n", qPrintable(error.toString()));
        }

        if (dummyData) {
            fprintf(stderr, "Loaded dummy data: %s\n", qPrintable(dir.filePath(qml)));
            qml.truncate(qml.length()-4);
            engine.rootContext()->setContextProperty(qml, dummyData);
            dummyData->setParent(&engine);
        }
    }
}


void usage()
{
    puts("qml-xmr 0.2.0");
    puts("Usage: qml-xmr [options] <filename>");
    puts(" Options:");
    puts("  --maximized ............................... Run maximized");
    puts("  --fullscreen .............................. Run fullscreen");
    puts("  --transparent ............................. Make the window transparent");
    puts("  --multisample ............................. Enable multisampling (OpenGL anti-aliasing)");
    puts("  --no-version-detection .................... Do not try to detect the version of the .qml file");
    puts("  --slow-animations ......................... Run all animations in slow motion");
    puts("  --resize-to-root .......................... Resize the window to the size of the root item");
    puts("  --quit .................................... Quit immediately after starting");
    puts("  --disable-context-sharing ................. Disable the use of a shared GL context for QtQuick Windows");
    puts("  -I <path> ................................. Add <path> to the list of import paths");
    puts("  -P <path> ................................. Add <path> to the list of plugin paths");
    puts("  -translation <translationfile> ............ Set the language to run in");

    puts(" ");
    exit(1);
}

QString randomTableFlip() {
    QStringList list{
            "¯\\_(ツ)_/¯",
            "̿༼ つ ◕_◕ ༽つ",
            "(ノಠ益ಠ)ノ彡┻━┻",
            "ლ(ಠ益ಠლ)",
            "┻━┻ ︵ヽ(`Д´)ﾉ︵ ┻━┻",
            "(¬_¬)",
            "╚(ಠ_ಠ)=┐",
            "ಠ╭╮ಠ",
            "(ง'̀-'́)ง"};
    int irand = rand() % list.length();
    return list.at(irand);
}

bool fileExists(QString path) {
    QFileInfo check_file(path);
    return check_file.exists() && (check_file.isFile() || check_file.isSymLink());
}

bool writeFile(const QString &path, const QString &data){
    return writeFile(path, data.toLocal8Bit());
}

bool writeFile(const QString &path, const QByteArray &data){
    QFile file(path);
    if(!file.open(QIODevice::WriteOnly)) {
        qCritical() << "fileOpen error:" << file.errorString();
        return false;
    }

    file.write(data);
    file.close();
    return true;
}

QString readFile(const QString &path){
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly)) {
        qCritical() << "fileOpen error:" << file.errorString();
        return QString("");
    }

    QTextStream in(&file);
    QString data = in.readAll();

    file.close();
    return data;
}

void printOut(QString msg){
    fprintf(stdout, qPrintable(QString("%1\n").arg(msg)));
}


void printErr(QString msg){
    fprintf(stderr, qPrintable(QString("%1\n").arg(msg)));
}
