#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "QMLcontext.h"
#include "Style.h"

// Create instance of test
CppContext mydata;

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // set context of application
    engine.rootContext()->setContextProperty("CppContext", &mydata);
    //declare custom enum
    StyleClass::declareQML();



    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);

        mydata.saveMainObject(obj);

    }, Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
