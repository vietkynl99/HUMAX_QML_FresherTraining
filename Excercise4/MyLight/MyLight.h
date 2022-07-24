#ifndef MYLIGHT_H
#define MYLIGHT_H

#include <QObject>
#include <QDebug>

class MyLight : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isOn READ isOn WRITE setIsOn NOTIFY lightChanged)

public:
    MyLight(QObject *parent = nullptr);

    bool isOn();
    bool getIsOn() const;
    void setIsOn(bool isOn);

public slots:
    void turnOn();
    void turnOff();

signals:
    void lightChanged();

private:
    bool mIsOn;
};

#endif // MYLIGHT_H
