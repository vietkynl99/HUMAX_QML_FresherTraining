import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: window
    width: 400
    height: 600
    visible: true
    title: "Light Controller"

    //property
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"

    //fill background color
    Rectangle {
        id: rectangle
        color: "#1f324b"
        anchors.fill: parent

        gradient: Gradient{
            orientation: Gradient.Horizontal
            GradientStop { position: 0; color: color_gradient_start}
            GradientStop { position: 1; color: color_gradient_end}
        }
    }

    MyButton {
        x: 29
        width: 200
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 200
        anchors.horizontalCenter: parent.horizontalCenter
        text_font: 12
        button_text: "TURN ON"
        onButtonClicked: controller.turnOn()
    }
    MyButton {
        x: 29
        width: 200
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 360
        anchors.horizontalCenter: parent.horizontalCenter
        text_font: 12
        button_text: "TURN OFF"
        onButtonClicked: controller.turnOff()
    }
}
