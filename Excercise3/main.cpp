#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Style.h"
#include "ListModelLib.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    //declare custom enum
    qmlRegisterType<StyleClass>("CustomQmlEnum", 1, 0, "RoleType");
    //declare class to the QML system.
    qmlRegisterType<MyListModel>("CustomListModel",1,0,"MyListModel");


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
