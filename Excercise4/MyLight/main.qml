import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: window
    width: 400
    height: 600
    visible: true
    title: "My Light"

    //property
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"

    //fill background color
    Rectangle {
        id: rectangle
        x: -439
        y: -178
        color: "#1f324b"
        anchors.fill: parent

        gradient: Gradient{
            orientation: Gradient.Horizontal
            GradientStop { position: 0; }
            GradientStop { position: 1; color: color_gradient_end}
        }
    }

    Image {
        id: imgLightOff
        x: 0
        width: 291
        height: 409
        anchors.top: parent.top
        source: "image/light_off.png"
        anchors.topMargin: 50
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }
    Image {
        id: imgLightOn
        x: imgLightOff.x
        y: imgLightOff.y
        width: imgLightOff.width
        height: imgLightOff.height
        source: "image/light_on.png"
        fillMode: Image.PreserveAspectFit
        state: "off"

        states: State {
            name: "off"
            when: !myLight.isOn
            PropertyChanges { target: imgLightOn; opacity: 0}
        }
        transitions: Transition {
            PropertyAnimation {property: "opacity"; duration: 400; easing.type: Easing.InQuad }
        }
    }

    MyButton {
        x: 29
        width: 200
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 500
        anchors.horizontalCenter: parent.horizontalCenter
        text_font: 12
        button_text: "TOGGLE"
        onButtonClicked: myLight.isOn = !myLight.isOn
    }

}
