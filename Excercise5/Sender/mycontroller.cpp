#include "mycontroller.h"


MyController::MyController(QObject *parent) : QObject(parent)
{
    theController = new local::MyData("cong.service.data", "/data",
                                      QDBusConnection::sessionBus(), this);
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
//    qDebug() << "Sent";
}
