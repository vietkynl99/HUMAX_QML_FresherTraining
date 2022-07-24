import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.1
import CustomQmlEnum 1.0
import CustomListModel 1.0

//Window {
ApplicationWindow {
    width: 800
    height: 600
    visible: true
    title: "Team Management"

    //property
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"
    property string selectedName: ""
    property int selectedAge: 0
    property int selectedRole: RoleType.TEAMLEADER
    property string msgTitle: ""
    property string msgText: ""
    property var msgIcon: StandardIcon.NoIcon
    property var cbDisplayText: ["Team Leader", "Developer", "BA", "Tester"]

    function convertRoleToColor(role)
    {
        switch(role)
        {
        case RoleType.TEAMLEADER:
            return "yellow"
        case RoleType.DEVELOPER:
            return "blue"
        case RoleType.BA:
            return "red"
        default:
            return "green"
        }
    }
    function getSelectedData(index)
    {
        if(index < listView.count && listView.count > 0)
        {
            var item = myList.getItem(index);
            selectedName = item.name
            selectedAge = item.age
            selectedRole = item.role
        }
    }

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

    menuBar: MenuBar {
        Menu {
            title: "&File"
            Action {
                text: "&Add New Member..."
                onTriggered: {
                    loader.source = ""
                    loader.sourceComponent = compAddNewMember
                }
            }
            MenuSeparator { }
            Action {
                text: "&Quit"
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: "&Help"
            Action {
                text: "&About"
                onTriggered: {
                    msgTitle = "About"
                    msgText = "Team Management Software\nVersion: 1.0"
                    msgIcon = "Information"
                    loader.sourceComponent = compMsg
                }
            }
        }
    }

    //loader
    Loader {
        id: loader
        anchors.fill: parent
    }

    // message dialog
    Component {
        id: compMsg
        MessageDialog {
            title: msgTitle
            text: msgText
            icon: msgIcon
            Component.onCompleted: visible = true
            //destroy loader Component
            onAccepted: loader.sourceComponent = undefined
        }
    }
    //dialog update data
    Component {
        id: compDialogUpdate
        Dialog {
            anchors.centerIn: parent
            title: "Update data"
            standardButtons: Dialog.Ok | Dialog.Cancel
            modal: true
            visible: true
            contentItem: Text {
                text: "Are you sure you want to update data?"
                font.pixelSize: 16
            }
            onAccepted: {
                myList.updateItem(listView.currentIndex, editName.text, comboBox.currentIndex, editAge.text)
                getSelectedData(listView.currentIndex)
                loader.sourceComponent = undefined   //destroy loader Component
            }
            onRejected: loader.sourceComponent = undefined
        }
    }
    //dialog deleta data
    Component {
        id: compDialogDelete
        Dialog {
            anchors.centerIn: parent
            title: "Delete data"
            standardButtons: Dialog.Ok | Dialog.Cancel
            modal: true
            visible: true
            contentItem: Text {
                text: "Are you sure you want to delete data?"
                font.pixelSize: 16
            }
            onAccepted: {
                myList.removeItem(listView.currentIndex)
                getSelectedData(listView.currentIndex)
                loader.sourceComponent = undefined   //destroy loader Component
            }
            onRejected: loader.sourceComponent = undefined
        }
    }

    //add new member
    Component {
        id: compAddNewMember
        AddNewMember {
            onAddNew: myList.addItem(name, role, age)
        }
    }

    //rectTeamMembers
    Rectangle {
        id: rectTeamMembers
        color: "#27495d"
        anchors.left: parent.left
        anchors.right: recInformation.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 40
        anchors.bottomMargin: 30
        anchors.leftMargin: 30
        anchors.topMargin: 50

        ListView {
            id: listView
            anchors.fill: parent
            clip: true
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            anchors.topMargin: 20
            delegate: Rectangle {
                id: rectMember
                width: parent.width
                height: 50
                color: rectTeamMembers.color

                Rectangle {
                    id: rectColor
                    width: parent.height
                    height: parent.height
                    color: convertRoleToColor(role)     //**
                    border.width: 1
                    border.color: "black"
                }
                Item {
                    id: rectName
                    anchors.left: rectColor.right
                    anchors.leftMargin: 0
                    anchors.right: rectAge.left
                    anchors.rightMargin: 0
                    height: parent.height
                    clip: true

                    Text {
                        text: name     //**
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        font.bold: true
                        font.pixelSize: 16
                        font.family: "Arial"
                        color: "whitesmoke"
                    }
                }
                Item {
                    id: rectAge
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    width: parent.height
                    height: parent.height
                    Text {
                        text: age     //**
                        anchors.centerIn: parent
                        font.bold: true
                        font.pixelSize: 16
                        font.family: "Arial"
                        color: "whitesmoke"
                    }
                }
                MouseArea {
                    id: btnMouse
                    height: parent.height
                    anchors.right: rectAge.right
                    anchors.rightMargin: 0
                    anchors.left: rectName.left
                    anchors.leftMargin: 0
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        listView.currentIndex = index
                        getSelectedData(index)
                    }
                }
                states: [
                    State {
                        name: "moved"
                        when: btnMouse.containsMouse && !btnMouse.pressed
                        PropertyChanges {target: rectMember; color: Qt.darker(rectTeamMembers.color, 1.2)}
                    },
                    State {
                        name: "selected"
                        //                        when: btnMouse.pressed
                        when: listView.currentIndex == index
                        PropertyChanges {target: rectMember; color: Qt.darker(rectTeamMembers.color, 1.6)}
                    }
                ]
                transitions:  Transition {
                    to: "*"
                    reversible: true
                    ColorAnimation {duration: 100}
                }
            }
            model: myList
        }
        MyListModel {
            id: myList
            inputFile: "saveFile.json"
        }
    }

    //recInformation
    Rectangle {
        id: recInformation
        x: 370
        width: 270
        color: "#27495d"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        clip: true
        anchors.bottomMargin: 30
        anchors.topMargin: 50
        anchors.rightMargin: 30

        MyButton {
            x: 29
            y: 271
            width: 200
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            button_text: "UPDATE"
            text_font: 12
            onButtonClicked: {
                if(listView.currentIndex >= 0 && listView.count > 0
                        && editName.text !== "" && editAge.text !== "" && !isNaN(editAge.text) && editAge.text > 0)
                {
                    msgTitle = "Update data"
                    msgText = "Are you sure you want to update data?"
                    loader.sourceComponent = compDialogUpdate
                }
                else
                {
                    msgTitle = "Notificaion"
                    msgText = "Error! Invalid name or age!"
                    msgIcon = "Critical"
                    loader.sourceComponent = compMsg
                }
            }
        }
        MyButton {
            x: 29
            y: 327
            width: 200
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            text_font: 12
            button_text: "DELETE"
            onButtonClicked: {
                if(listView.currentIndex >= 0 && listView.count > 0)
                    loader.sourceComponent = compDialogDelete
            }
        }

        TextInput {
            id: editName
            x: 68
            y: 40
            width: 181
            height: 38
            text: selectedName
            font.pixelSize: 14
            clip: true
            color: "whitesmoke"
            focus: false
            selectByMouse: true
            cursorVisible: false
        }
        TextInput {
            id: editAge
            x: 68
            y: 100
            width: 181
            height: 38
            color: "#f5f5f5"
            text: selectedAge
            font.pixelSize: 14
            clip: true
            focus: false
            selectByMouse: true
            cursorVisible: false
        }

        Text {
            id: text3
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
        Text {
            x: 21
            y: 158
            color: "#f5f5f5"
            text: qsTr("Role:")
            font.pixelSize: 14
        }

        ComboBox {
            id: comboBox
            x: 73
            y: 154
            width: 156
            height: 29
            currentIndex: selectedRole
            //            model: ["Team Leader", "Developer", "BA", "Tester"]
            displayText: cbDisplayText[selectedRole]
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
                        selectedRole = index
                        comboBox.currentIndex = index
                        comboBox.popup.close()
                    }
                }
            }
        }

    }

    Text {
        x: 50
        y: 26
        color: "whitesmoke"
        text: qsTr("Team Members")
        font.pixelSize: 16
        font.family: "Arial"
    }

    Text {
        x: 520
        y: 26
        color: "whitesmoke"
        text: qsTr("Information")
        font.pixelSize: 16
        font.family: "Arial"
    }

    Component.onCompleted: getSelectedData(listView.currentIndex)
    onClosing: myList.saveListModelToFile()
}


