#include "MyLight.h"

MyLight::MyLight(QObject *parent) : QObject(parent)
{
    mIsOn = false;
}

bool MyLight::isOn()
{
    return mIsOn;
}

bool MyLight::getIsOn() const
{
    return mIsOn;
}

void MyLight::setIsOn(bool isOn)
{
    if(mIsOn != isOn){
        mIsOn = isOn;
        emit lightChanged();
    }
}

void MyLight::turnOn()
{
    setIsOn(true);
    qDebug() << "turnOn is called";
}

void MyLight::turnOff()
{
    setIsOn(false);
    qDebug() << "turnOff is called";
}


