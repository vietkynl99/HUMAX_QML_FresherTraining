import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.1

Window {
    id: window
    width: 300
    height: 300
    visible: true
    title: "Add New Member"

    //property
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"
    property var cbDisplayText: ["Team Leader", "Developer", "BA", "Tester"]

    //signal
    signal addNew(string name, int role, int age)

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

    TextInput {
        id: editName
        x: 68
        y: 40
        width: 181
        height: 38
        text: ""
        font.pixelSize: 14
        selectByMouse: true
        cursorVisible: true
        clip: true
        color: "whitesmoke"
        focus: true
    }
    TextInput {
        id: editAge
        x: 68
        y: 100
        width: 181
        height: 38
        color: "#f5f5f5"
        text: ""
        font.pixelSize: 14
        selectByMouse: true
        cursorVisible: true
        clip: true
        focus: true
    }

    Text {
        x: 21
        y: 40
        text: qsTr("Name:")
        font.pixelSize: 14
        color: "whitesmoke"
    }
    Text {
        x: 21
        y: 100
        color: "#f5f5f5"
        text: qsTr("Age:")
        font.pixelSize: 14
    }
//    ComboBox {
//        id: comboBox
//        x: 73
//        y: 154
//        width: 156
//        height: 29
//        clip: true
//        currentIndex: 0
//        model: [ "Team Leader", "Developer", "BA", "Tester" ]
//    }

    ComboBox {
        id: comboBox
        x: 73
        y: 154
        width: 156
        height: 29
        currentIndex: 0
        displayText: cbDisplayText[currentIndex]
        model: ListModel {
            id: listImg
            ListElement {soureImg: "image/teamleader.jpg"}
            ListElement {soureImg: "image/developer.jpg"}
            ListElement {soureImg: "image/ba.jpg"}
            ListElement {soureImg: "image/tester.jpg"}
        }
        delegate: Image {
            width: parent.width
            height: 40
            source: soureImg
            fillMode: Image.PreserveAspectCrop
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    comboBox.currentIndex = index
                    comboBox.popup.close()
                }
            }
        }
    }

    Text {
        x: 21
        y: 158
        color: "#f5f5f5"
        text: qsTr("Role:")
        font.pixelSize: 14
    }

    MyButton {
        id: btnQml
        x: 21
        y: 223
        width: 258
        height: 40
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        button_text: "ADD MEMBER"
        text_font: 12
        onButtonClicked: {
            if(editName.text !== "" && editAge.text !== "" && !isNaN(editAge.text) && editAge.text > 0)
                addNew(editName.text, comboBox.currentIndex, editAge.text)
            else
                loader.sourceComponent = compWarnMsg
        }
    }

    Loader {
        id: loader
    }

    //message box
    Component {
        id: compWarnMsg
        MessageDialog {
            id: messageBox
            title: "Notificaion"
            text: "Error! Invalid name or age!"
            icon: "Critical"
            Component.onCompleted: visible = true
            //destroy loader Component
            onAccepted: loader.sourceComponent = undefined
        }
    }

}
