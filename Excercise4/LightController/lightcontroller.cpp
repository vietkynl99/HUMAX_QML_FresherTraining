#include "lightcontroller.h"


LightController::LightController(QObject *parent) : QObject(parent)
{
//    theLight = new cong::service::light("cong.service.light", "/light",
//                                        QDBusConnection::sessionBus(), this);

//    theLight = new local::MyLight("local.MyLight", "/light",
//                                        QDBusConnection::sessionBus(), this);

    theLight = new local::MyLight("cong.service.light", "/light",
                                        QDBusConnection::sessionBus(), this);
}

void LightController::turnOn()
{
    theLight->turnOn();
//    qDebug() << "turn on";
}

void LightController::turnOff()
{
    theLight->turnOff();
//    qDebug() << "turn off";
}


