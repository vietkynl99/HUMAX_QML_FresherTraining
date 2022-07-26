#ifndef MYDATA_H
#define MYDATA_H

#include <QObject>
#include <QDebug>
#include <QMetaType>
#include <QDBusMetaType>
#include <QDBusArgument>
#include <QtDBus>
#include <QImage>
#include <QQmlProperty>

class MyData : public QObject
{
    Q_OBJECT

public:
    MyData(QObject *parent = nullptr);
    void saveMainObject(QObject *_obj);

public slots:
    void sendData(QByteArray arr);

private:
    QObject *mainObj;
};

#endif // MYDATA_H
