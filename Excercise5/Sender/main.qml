import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.3
import Qt.labs.platform 1.1
import Qt.labs.folderlistmodel 2.12

Window {
    id: root
    width: 400
    height: 700
    visible: true
    title: "Sender"

    //property
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"
    property string img_path: ""                        //ex: file:///C:/Users/dhviet/Downloads/light.png (use for image QML)
    property string img_send_path: ""                   //ex: C:/Users/dhviet/Downloads/light.png (use for C++ function)
    property int fileIndex: 0

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

    Item {
        width: 400
        height: 700
        anchors.centerIn: parent
        scale: Math.min(root.width/width, root.height/height)

        Rectangle {
            id: rectImg
            height: 380
            color: "#244a6d"
            border.color: "#567c99"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 40
            anchors.leftMargin: 40
            anchors.topMargin: 40
        }

        Image {
            anchors.fill: rectImg
            source: img_path
            fillMode: Image.PreserveAspectFit
            //        onSourceChanged: playing = true
        }


        MyButton {
            x: 29
            y: 460
            width: rectImg.width
            height: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            text_font: 12
            button_text: "SELECT"
            onButtonClicked: folderDialog.visible = true
        }
        MyButton {
            x: 29
            y: 510
            width: rectImg.width
            height: 40
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            text_font: 12
            button_text: "SEND"
            onButtonClicked: {
                if(img_send_path != "")
                    mySender.sendData(img_send_path)
            }
        }

        FolderDialog {
            id: folderDialog
            visible: false
        }

        FolderListModel {
            id: folderModel
            folder: folderDialog.currentFolder
            showDirs: false
            nameFilters: ["*.jpg", "*.png"]
        }

        Text {
            id: txtFilePath
            width: rectImg.width
            clip: true
            color: "#ffffff"
            text: folderModel.count>0 ? folderModel.get(fileIndex, "fileURL") : ""
            anchors.top: rectImg.bottom
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            lineHeightMode: Text.ProportionalHeight
            wrapMode: Text.WordWrap
            anchors.topMargin: 20
            fontSizeMode: Text.FixedSize
            maximumLineCount: 4
            anchors.horizontalCenter: parent.horizontalCenter
            onTextChanged: {
                if(fileIndex<folderModel.count)
                {
                    img_path = folderModel.get(fileIndex, "fileURL")
                    img_send_path = img_path.replace("file:///", "")
                }
            }
        }

        MyButton {
            y: 466
            width: 155
            height: 40
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 40
            text_font: 22
            button_text: "<"
            anchors.bottomMargin: 130
            onButtonClicked: fileIndex = fileIndex>0 ? fileIndex-1 : fileIndex
        }

        MyButton {
            y: 466
            width: 155
            height: 40
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 40
            text_font: 22
            button_text: ">"
            anchors.bottomMargin: 130
            onButtonClicked: fileIndex = fileIndex<folderModel.count-1 ? fileIndex+1 : fileIndex
        }

    }
}
