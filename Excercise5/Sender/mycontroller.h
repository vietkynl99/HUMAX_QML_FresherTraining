#ifndef MYCONTROLLER_H
#define MYCONTROLLER_H


#include <QObject>
#include <QDebug>
#include <QQmlProperty>
#include "data_interface.h"

class MyController : public QObject
{
    Q_OBJECT
public:
    MyController(QObject *parent = nullptr);
    void saveMainObject(QObject *_obj);

signals:
    void request();

public slots:
    void sendData(QString filepath);
    void requestSlot();

private:
    QObject *mainObj;
    local::MyData *theController;
};

#endif // MYCONTROLLER_H
