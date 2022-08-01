#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "mysender.h"


MySender mySender;

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    app.setOrganizationName("HUMAX");
    app.setOrganizationDomain("humaxdigital.com");
    app.setApplicationName("Sender Application");

    engine.rootContext()->setContextProperty("mySender", &mySender);



    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);

        mySender.saveMainObject(obj);

    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
