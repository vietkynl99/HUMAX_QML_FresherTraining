#ifndef LIGHTCONTROLLER_H
#define LIGHTCONTROLLER_H

#include <QObject>
#include <QDebug>
#include "light_interface.h"

class LightController : public QObject
{
    Q_OBJECT
public:
    LightController(QObject *parent = nullptr);

public slots:
    void turnOn();
    void turnOff();

private:
//    cong::service::light *theLight;
    local::MyLight *theLight;
};

#endif // LIGHTCONTROLLER_H
