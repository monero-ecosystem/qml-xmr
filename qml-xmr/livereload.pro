TEMPLATE = app
TARGET = /usr/local/bin/qml-xmr
SOURCES += main.cpp

HEADERS += \
    test/oscursor.h

SOURCES += \
    test/oscursor.cpp

QT += qml quick
mac: {
    CONFIG -= app_bundle
}
