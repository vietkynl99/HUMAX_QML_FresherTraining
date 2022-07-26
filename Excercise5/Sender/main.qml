import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.3

Window {
    id: window
    width: 400
    height: 600
    visible: true
    title: "Sender"

    //property
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"
    property string img_path: ""                        //ex: file:///C:/Users/dhviet/Downloads/light.png (use for image QML)
    property string img_send_path: ""                   //ex: C:/Users/dhviet/Downloads/light.png (use for C++ function)

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

    AnimatedImage {
        anchors.fill: rectImg
        source: img_path
        fillMode: Image.PreserveAspectFit
        onSourceChanged: playing = true
    }


    MyButton {
        x: 29
        y: 460
        width: rectImg.width
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        text_font: 12
        button_text: "SELECT"
        onButtonClicked: fileDialog.visible = true
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
        button_text: "SEND"
        onButtonClicked: {
            if(img_send_path != "")
                mycontroller.sendData(img_send_path)
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        visible: false
        onAccepted: {
            img_path = fileDialog.fileUrl
            img_send_path = img_path.replace("file:///", "")
        }
    }

}
