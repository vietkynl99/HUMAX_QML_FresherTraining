import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.1

Window {
    id: mainWindown
    width: 1080
    height: 720
    visible: true
    title: "Control system"
    property int rect_menu_width: 170
    property int rect_button_height: 70
    property string color_menu: "#284B6A"
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"

    function updateDatetime()
    {
        textTime.text = Qt.formatDateTime(new Date(), "ddd dd/MM/yyyy hh:mm:ss")
    }

    //menu
    Rectangle{
        id: rectMenu
        width: rect_menu_width
        height: parent.height
        color: color_menu

        //logo
        Rectangle{
            id: rectLogo
            width: parent.width
            height: 150
            color: parent.color
            Image {
                source: "image/Logo.png"
                anchors.topMargin: 25
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                width: 70
                height: width
                anchors.top: parent.top
                fillMode: Image.PreserveAspectFit
            }
            Text {
                text: "CONTROL SYSTEM"
                anchors.top: parent.top
                font.pixelSize: 16
                anchors.topMargin: 105
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        //menu
        MenuBar{
            id: menu
            x: 0; y: rectLogo.height
            width: parent.width
            height: parent.height - y
            backgroundColor: color_menu
            pressColor: color_gradient_start
            onItemSelected: {
                switch (idx)
                {
                case 0 : {
                    myLoader.width = 350
                    myLoader.height = 300
                    myLoader.source = "MyCppContext.qml"
                    break;
                }
                case 1 : {
                    myLoader.width = rectMainArea.width
                    myLoader.height = rectMainArea.height
                    myLoader.source = "AmongUs.qml"
                    break;
                }
                case 2 : {
                    myLoader.width = rectMainArea.width
                    myLoader.height = rectMainArea.height
                    myLoader.source = "MyButtonState.qml"
                    break;
                }
                case 3 : {
                    myLoader.width = rectMainArea.width
                    myLoader.height = rectMainArea.height
                    myLoader.source = "MyPicture.qml"
                    break;
                }
                default : {
                    myLoader.sourceComponent = compWarnMsg
                }
                }
                //                notification.text = "Notification: You pressed menu " + (idx + 1).toString() + "!"
            }
        }
    }

    //User info
    Rectangle{
        id: rectUserInfo
        anchors.right: parent.right
        anchors.rightMargin: 0
        width: parent.width - rectMenu.width
        height: 60
        color: color_gradient_start

        Image {
            id: imgAvatar
            source: "image/Avatar.png"
            anchors.rightMargin: 20
            anchors.topMargin: 10
            width: 40
            height: width
            anchors.right: parent.right
            anchors.top: parent.top
            fillMode: Image.PreserveAspectFit
        }
        Text {
            id: userName
            text: "Viet Kynl"
            anchors.right: parent.right
            anchors.top: parent.top
            font.pixelSize: 16
            anchors.rightMargin: 65
            color: "white"
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 20
        }
    }

    //Main UI
    Rectangle {
        id: rectMainArea
        width: parent.width - rectMenu.width
        height: parent.height - rectUserInfo.height
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0

        gradient: Gradient{
            orientation: Gradient.Horizontal
            GradientStop { position: 0; color: color_gradient_start}
            GradientStop { position: 1; color: color_gradient_end}
        }
        Text {
            id: notification
            text: ""
            anchors.top: parent.top
            font.pixelSize: 16
            color: "white"
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Loader {
            id: myLoader
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    //message box
    Component {
        id: compWarnMsg
        MessageDialog {
            id: messageBox
            title: "Notificaion"
            text: "This menu is empty!"
            icon: "Critical"
            Component.onCompleted: visible = true
            //destroy loader Component
            onAccepted: myLoader.sourceComponent = undefined
        }
    }

    //show time
    Text {
        id: textTime
        x: 900
        y: 66
        text: ""
        anchors.right: parent.right
        font.pixelSize: 20
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.rightMargin: 16
    }
    Timer {
        id: timer
        interval: 1000
        repeat: true
        running: true
        onTriggered: updateDatetime()
    }

    //first run
    Component.onCompleted: {
        updateDatetime()
    }
}
