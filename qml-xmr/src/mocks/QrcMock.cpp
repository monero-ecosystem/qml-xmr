#include <QRegularExpressionMatch>

#include "src/mocks/QrcMock.h"
#include "src/utils.h"


int QrcMock::install(){
    if (!QResource::registerResource(this->m_path_compiled.absoluteFilePath())) {
        printErr(QString("Cannot load %1").arg(this->path));
        return 0;
    }
    return 1;
}

int QrcMock::compile(){
    QByteArray data = this->m_data.toLocal8Bit();
    QFileInfo path_tmp = QFileInfo(QString(this->m_path_info.absolutePath() + "/qml.qrc.tmp"));
    QFileInfo path_tmp_compiled = QFileInfo(this->m_path_info.absolutePath() + "/qml.rcc");
    QString path_tmp_compiled_str = path_tmp_compiled.absoluteFilePath();

    writeFile(path_tmp.absoluteFilePath(), data);
    //qDebug() << QString("Written tmp qrc to %1").arg(path_tmp.absoluteFilePath());

    QProcess process;
    QStringList rcc_args;
    rcc_args << QString("-binary");
    rcc_args << QString(path_tmp.absoluteFilePath());
    rcc_args << QString("-o");
    rcc_args << path_tmp_compiled_str;

    process.start("rcc", rcc_args);
    process.waitForFinished(3000);

    QString rcc_stderr(process.readAllStandardError());
    if (!rcc_stderr.isEmpty()) {
        printErr("Failed to generate external resource binary `qml.rcc`");
        printErr(QString("> rcc %1").arg(rcc_args.join(" ")));
        printErr(rcc_stderr);
        return 0;
    }

    qDebug() << QString("Compiled qrc to %1").arg(path_tmp_compiled_str);

    this->m_path_tmp = path_tmp;
    this->m_path_compiled = path_tmp_compiled;

    // cleanup
    // QFile file_tmp(path_tmp.absoluteFilePath());
    // file_tmp.remove();
    return 1;
}

int QrcMock::load(const QString &path){
    this->m_path_info = QFileInfo(path);

    QString data = readFile(path);
    QByteArray xmlText;

    QStringList matches;
    QRegularExpression reA("\\<file\\>([@\\-\\w+\\/]+(qmldir|\\.png|\\.qml|\\.svg|\\.ttf))\\<\\/file\\>");
    QRegularExpressionMatchIterator i = reA.globalMatch(data);
    int matched = 0;
    while (i.hasNext()) {
        QRegularExpressionMatch match = i.next();
        if (match.hasMatch()) {
            QString path_match = QString("%1/%2").arg(this->m_path_info.absolutePath(), match.captured(1));
            if(fileExists(path_match) || path_match.endsWith("qmldir")){
                matched += 1;
                matches.append(match.captured(0));
            } else {
                // missing static resources
                //qDebug() << "Ignoring invalid qrc path: " << path_match;
            }
        }
    }

    if(matched == 0){
        qCritical() << QString("Read \"%1\", no matches").arg(path);
        return matched;
    }

    qDebug() << QString("Rebuilt qrc with %1 entries").arg(QString::number(matched));
    QString qrc_stripped = QString("<RCC>\n    <qresource prefix=\"/\">\n        %1\n    </qresource>\n</RCC>").arg(matches.join("\n        "));
    this->m_data = qrc_stripped;

    return matched;
}