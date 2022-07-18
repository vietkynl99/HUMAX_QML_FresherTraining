#ifndef QMLCONTEXT_H
#define QMLCONTEXT_H

#include <QObject>
#include <QDebug>

class myData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int myvalue READ myvalue WRITE setMyvalue NOTIFY myvalueChanged)

private:
    int m_myvalue;

public:
    myData(QObject *parent = 0)
    {
        m_myvalue = 10;
    }

    int myvalue()
    {
        return m_myvalue;
    }
    void setMyvalue(int _myvalue)
    {
        m_myvalue = _myvalue;
        qDebug() << "setMyvalue() is called";
        // send signal to notify change
        Q_EMIT myvalueChanged();
    }

public slots:
    void callReset()
        {
           m_myvalue = 0;
           qDebug() << "callReset() is called from C++";
           // send signal to notify change
           Q_EMIT myvalueChanged();
           // send signal to QML via signal
           Q_EMIT showAText(m_myvalue, "callReset");
        }
        void callSet(int _myvalue)
        {
           m_myvalue = _myvalue;
           qDebug() << "callSet() is called from C++";
           // send signal to notify change
           Q_EMIT myvalueChanged();
           // send signal to QML via signal
           Q_EMIT showAText(m_myvalue, "callSet");
        }
Q_SIGNALS:
    void myvalueChanged();
    void showAText(int index, const QString &message);
};

#endif // QMLCONTEXT_H
