QT       += qml quick quickcontrols2

CONFIG += c++17

VERSION = 0.1.0.0
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

TARGET = DIIRLootFilterEditor
TEMPLATE = app

SOURCES += main.cpp \
    filehandler.cpp

HEADERS += filehandler.h

RESOURCES += qml.qrc \
    qtquickcontrols2.conf \
    MaterialIcons/materialicons.qrc \
    QML/diirlf.qrc
