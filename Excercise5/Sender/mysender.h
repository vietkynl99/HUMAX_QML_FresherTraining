#ifndef MYSENDER_H
#define MYSENDER_H


#include <QObject>
#include <QDebug>
#include <QQmlProperty>
#include "data_interface.h"

class MySender : public QObject
{
    Q_OBJECT
public:
    MySender(QObject *parent = nullptr);
    void saveMainObject(QObject *_obj);

signals:
    void request();

public slots:
    void sendData(QString filepath);
    void requestSlot();

private:
    QObject *mainObj;
    local::MyReceiver *receiver;
};

#endif // MYSENDER_H
