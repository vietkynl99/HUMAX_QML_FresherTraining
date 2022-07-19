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

        enum EnStyle
        {
            BOX,
            CIRCLE,
            TRIANGLE
        };
        Q_ENUMS(EnStyle)

        // Do not forget to declare your class to the QML system.
        static void declareQML() {
            qmlRegisterType<StyleClass>("CustomQmlEnum", 1, 0, "ShapeType");
        }
};
#endif // STYLE_H
