#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "MyLight.h"
#include "light_adaptor.h"


int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    // Create new instance
    MyLight myLight;
    engine.rootContext()->setContextProperty("myLight", &myLight);


    // Create interface adaptor
    new MyLightAdaptor(&myLight);

    // Connect to session bus
    QDBusConnection connection = QDBusConnection::sessionBus();

    connection.registerObject("/light", &myLight);
    if(!connection.registerService("cong.service.light"))
    {
        qCritical() << connection.lastError().message();
        qFatal("Cannot register DBus service, server started? run dbus-launch.exe");
    }

    if(!connection.isConnected())
        qFatal("Cannot connect to the D-Bus\n");


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
