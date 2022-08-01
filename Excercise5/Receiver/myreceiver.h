#ifndef MYRECEIVER_H
#define MYRECEIVER_H

#include <QObject>
#include <QDebug>
#include <QMetaType>
#include <QDBusMetaType>
#include <QDBusArgument>
#include <QtDBus>
#include <QImage>
#include <QQmlProperty>
#include "data_adaptor.h"


class MyReceiver : public QObject
{
    Q_OBJECT

public:
    MyReceiver(QObject *parent = nullptr);

signals:
    void request();
    void getDone();

public slots:
    void getData(QByteArray arr);
    void requestSlot();

private:
    QObject *mainObj;
};

#endif // MYRECEIVER_H
