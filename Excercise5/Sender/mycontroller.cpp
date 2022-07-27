#include "mycontroller.h"


MyController::MyController(QObject *parent) : QObject(parent)
{
    theController = new local::MyData("cong.service.data", "/data",
                                      QDBusConnection::sessionBus(), this);
    //connect signal to slot
    connect(theController, SIGNAL(request()), this, SLOT(requestSlot()));
}

void MyController::saveMainObject(QObject *_obj)
{
    mainObj = _obj;
}

void MyController::sendData(QString filepath)
{
    QFile file(filepath);
    if (!file.open(QFile::ReadOnly))
    {
        qDebug() << "Error! Can't open input file!";
        return;
    }
    QByteArray array = file.readAll();
    file.close();

    theController->sendData(array);
}

void MyController::requestSlot()
{
    //get img_path from property
    QString path = QQmlProperty::read(mainObj, "img_send_path").toString();
    //send
    if(path != "")
        sendData(path);
}
