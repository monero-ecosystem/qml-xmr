TEMPLATE = app
TARGET = /usr/local/bin/qml-xmr
SOURCES += main.cpp

HEADERS += \
    oscursor.h

SOURCES += \
    oscursor.cpp

QT += qml quick
mac: {
    CONFIG -= app_bundle
}
