import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: window
    width: 400
    height: 600
    visible: true
    title: "Receiver"

    //property
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"
    property string img_path: ""

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

    Rectangle {
        id: rectImg
        color: "#244a6d"
        border.color: "#567c99"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 40
        anchors.leftMargin: 40
        anchors.bottomMargin: 180
        anchors.topMargin: 40
    }

    Image {
        id: img
        anchors.fill: rectImg
        source: "image://imageprovider/"
        fillMode: Image.PreserveAspectFit
        cache: false

        function reload() {
            var oldSource = source;
            source = "";
            source = oldSource;
            console.log("reload")
        }
        Connections {
            target: myReceiver
            onGetDone: img.reload();
        }
    }



    MyButton {
        x: 29
        y: 510
        width: rectImg.width
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        text_font: 12
        button_text: "REQUEST"
        onButtonClicked: myReceiver.requestSlot()
    }


}
