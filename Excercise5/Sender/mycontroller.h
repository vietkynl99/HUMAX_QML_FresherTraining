#ifndef MYCONTROLLER_H
#define MYCONTROLLER_H


#include <QObject>
#include <QDebug>
#include "data_interface.h"

class MyController : public QObject
{
    Q_OBJECT
public:
    MyController(QObject *parent = nullptr);

public slots:
    void sendData(QString filepath);

private:
    local::MyData *theController;
};

#endif // MYCONTROLLER_H
