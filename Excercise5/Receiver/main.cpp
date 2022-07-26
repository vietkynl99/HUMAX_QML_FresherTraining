#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "mydata.h"
#include "data_adaptor.h"

MyData myData;

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    // Create new instance
    engine.rootContext()->setContextProperty("myData", &myData);

    // Create interface adaptor
    new MyDataAdaptor(&myData);
    // Connect to session bus
    QDBusConnection connection = QDBusConnection::sessionBus();

    connection.registerObject("/data", &myData);
    if(!connection.registerService("cong.service.data"))
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

        myData.saveMainObject(obj);

    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
