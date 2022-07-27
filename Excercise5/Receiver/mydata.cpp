#include "mydata.h"

MyData::MyData(QObject *parent) : QObject(parent)
{

}

void MyData::saveMainObject(QObject *_obj)
{
    mainObj = _obj;
}

void MyData::sendData(QByteArray arr)
{
    QString resultString = QString::fromLatin1("data:image/png;base64,") + QString::fromLatin1(arr.toBase64().data());

    //set property
    QQmlProperty::write(mainObj, "img_path", resultString);
}

void MyData::requestSlot()
{
    emit request();
}

