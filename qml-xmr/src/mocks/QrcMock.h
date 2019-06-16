#ifndef QML_XMR_QRCMOCK_H
#define QML_XMR_QRCMOCK_H

#include <QStringList>
#include <QDir>
#include <QString>
#include <QObject>
#include <QFileInfo>
#include <QResource>
#include <QProcess>


class QrcMock {
    QString path;

public:
    int install();
    int load(const QString &path);
    int compile();

private:
    QFileInfo m_path_info;
    QFileInfo m_path_tmp;
    QFileInfo m_path_compiled;
    QString m_data;
};

#endif //QML_XMR_QRCMOCK_H
