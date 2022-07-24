import QtQuick 2.0

Item {
    id: myItem
    width: 400
    height: 400

    Rectangle {
        id: btnRect
        width: 120
        height: 60
        color: "blue"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: btnText
            color: "white"
            text: "text"
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 18
            anchors.horizontalCenter: parent.horizontalCenter

        }
        MouseArea {
            anchors.fill: parent
            onPressed: {
                if(myItem.state == "normal")
                {
                    myItem.state = "pressed"
                    btnTimer.start()
                }
                else
                    myItem.state = "normal"
            }
            onReleased: {
                if(myItem.state == "pressed")
                {
                    myItem.state = "normal"
                    btnTimer.stop()
                }
            }
        }
    }

    Timer {
        id: btnTimer
        interval: 1000
        onTriggered: {
            myItem.state = "selected"
            stop()
        }
    }

    states: [
        State {
            name: "normal"
            PropertyChanges {target: btnRect; color: "#299FC7"}
            PropertyChanges {target: btnText; text: "Normal"}
        },
        State {
            name: "pressed"
            PropertyChanges {target: btnRect; color: "#1f7895"}
            PropertyChanges {target: btnText; text: "Pressed"}
        },
        State {
            name: "selected"
            PropertyChanges {target: btnRect; color: "#249F72"}
            PropertyChanges {target: btnText; text: "Selected"}
        }
    ]

    Component.onCompleted: myItem.state = "normal"
}
