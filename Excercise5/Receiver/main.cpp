#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "myreceiver.h"
#include "imageprovider.h"


ImageProvider *imgProvider;

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;


    MyReceiver myReceiver;
    // Create new instance
    engine.rootContext()->setContextProperty("myReceiver", &myReceiver);

    // Create interface adaptor
    new MyReceiverAdaptor(&myReceiver);
    // Connect to session bus
    QDBusConnection connection = QDBusConnection::sessionBus();

    connection.registerObject("/data", &myReceiver);
    if(!connection.registerService("cong.service.data"))
    {
        qCritical() << connection.lastError().message();
        qFatal("Cannot register DBus service, server started? run dbus-launch.exe");
    }
    if(!connection.isConnected())
        qFatal("Cannot connect to the D-Bus\n");

    //image provider
    imgProvider = new ImageProvider;
    engine.addImageProvider(QLatin1String("imageprovider"), imgProvider);


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
