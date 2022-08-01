#include "mysender.h"


MySender::MySender(QObject *parent) : QObject(parent)
{
    receiver = new local::MyReceiver("cong.service.data", "/data",
                                      QDBusConnection::sessionBus(), this);
    //connect signal to slot
    connect(receiver, SIGNAL(request()), this, SLOT(requestSlot()));
}

void MySender::saveMainObject(QObject *_obj)
{
    mainObj = _obj;
}

void MySender::sendData(QString filepath)
{
    QFile file(filepath);
    if (!file.open(QFile::ReadOnly))
    {
        qDebug() << "Error! Can't open input file!";
        return;
    }
    QByteArray array = file.readAll();
    file.close();

    receiver->getData(array);
}

void MySender::requestSlot()
{
    //get img_path from property
    QString path = QQmlProperty::read(mainObj, "img_send_path").toString();
    //send
    if(path != "")
        sendData(path);
}
