#ifndef MYCLASS_H
#define MYCLASS_H

#include <QObject>
#include <QMetaType>
#include <QDBusMetaType>
#include <QDBusArgument>

class MyStructure
{

public:
    int count;
    QString name;

    // Marshall the MyStructure data into a D-Bus argument
    friend QDBusArgument &operator<<(QDBusArgument &argument, const MyStructure &myStruct)
    {
        argument.beginStructure();
        argument << myStruct.count << myStruct.name;
        argument.endStructure();
        return argument;
    }

    // Retrieve the MyStructure data from the D-Bus argument
    friend const QDBusArgument &operator>>(const QDBusArgument &argument, MyStructure &myStruct)
    {
        argument.beginStructure();
        argument >> myStruct.count >> myStruct.name;
        argument.endStructure();
        return argument;
    }

    void registerMetaType()
    {
//        qRegisterMetaType<MyStructure>("MyStructure");
//        qDBusRegisterMetaType<MyStructure>();
    }

};


#endif // MYCLASS_H
