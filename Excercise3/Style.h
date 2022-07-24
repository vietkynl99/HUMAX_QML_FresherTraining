#ifndef STYLE_H
#define STYLE_H

#include <QQmlEngine>
#include <QObject>


// Required derivation from QObject
class StyleClass : public QObject
{
    Q_OBJECT

    public:
        // Default constructor, required for classes you expose to QML.
        StyleClass() : QObject() {}

        enum EnumRole
        {
            TEAMLEADER,
            DEVELOPER,
            BA,
            TESTER
        };
        Q_ENUMS(EnumRole)
};
#endif // STYLE_H
