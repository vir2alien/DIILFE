#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFont>
#include <QQuickStyle>

#include "filehandler.h"

int main(int argc, char *argv[]) {
    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));
    qputenv("QML_XHR_ALLOW_FILE_WRITE", QByteArray("1"));

    QCoreApplication::setOrganizationName("GladSoft");
    QString ver(APP_VERSION);
    QCoreApplication::setApplicationName("DIIR LootFilter Editor");

    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");
    QFont font("Arial");
    app.setFont(font);


    QQmlApplicationEngine engine;
    qmlRegisterType<FileHandler>("DIIRLFE", 1, 0, "FileHandler");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
