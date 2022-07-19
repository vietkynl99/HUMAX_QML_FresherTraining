#ifndef QMLCONTEXT_H
#define QMLCONTEXT_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlComponent>
#include <QQmlProperty>
#include <QObject>
#include <QDebug>
#include <cstring>
#include "Style.h"

class CppContext : public QObject
{
    Q_OBJECT

private:
    QObject *mainObj;

public:
    void saveMainObject(QObject *_obj)
    {
        mainObj = _obj;
    }

    //public slots:
    Q_INVOKABLE void callReset()
    {
        //read box shape property
        int _type =  QQmlProperty::read(mainObj, "selectedBoxType").toInt();
        QString _color =  QQmlProperty::read(mainObj, "selectedBoxColor").toString();
        int _value =  QQmlProperty::read(mainObj, "selectedBoxValue").toInt();
        //select list model object
        QObject *listObj = mainObj->findChild<QObject*>("listShape");
        if (listObj)
        {
            QVariantMap newElement;
            newElement.insert("type", _type);
            newElement.insert("color", _color);
            newElement.insert("value", _value);

            QMetaObject::invokeMethod(listObj, "addNewItem",
                                      Q_ARG(QVariant, QVariant::fromValue(newElement)));
        }
    }
};

#endif // QMLCONTEXT_H
