#include "myreceiver.h"
#include "imageprovider.h"

MyReceiver::MyReceiver(QObject *parent) : QObject(parent)
{

}

void MyReceiver::getData(QByteArray arr)
{
    //method 1
    //QString resultString = QString::fromLatin1("data:;base64,") + QString::fromLatin1(arr.toBase64().data());

    //method 2
    qDebug () << "get";
    imgProvider->image.loadFromData(arr);
    emit getDone();
    qDebug() << "received";
}

void MyReceiver::requestSlot()
{
    emit request();
}

