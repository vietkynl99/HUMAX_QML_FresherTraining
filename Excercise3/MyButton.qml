import QtQuick 2.0

Item {
    id: root
    width: 170
    height: 70
    property bool button_enable: true
    property string background_color: "#1B5C98"
    property string selected_color: "black"
    property string button_text: "text"
    property string text_color: "whitesmoke"
    property int text_font: 22
    property int border_width: 0
    property string border_color: "white"
    signal buttonClicked()
    signal buttonReleased()
    signal buttonPressed()

    Rectangle{
        id: btnRect
        color: background_color
        border.width: border_width
        border.color: border_color
        anchors.fill: parent

        Text {
            text: button_text
            font.pixelSize: text_font
            color: text_color
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.centerIn: parent
        }
        MouseArea{
            id: btnMouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: buttonClicked()
            onPressed: buttonPressed()
            onReleased: buttonReleased()
        }
    }

    states: [
        State {
            name: "disable"
            when: !button_enable
            PropertyChanges {target: btnRect; color: Qt.tint(background_color, "#3F5A74")}      //change to lighter color
        },
        State {
            name: "moved"
            when: btnMouse.containsMouse && !btnMouse.pressed && button_enable
            PropertyChanges {target: btnRect; color: Qt.darker(background_color, 1.2)}      //change to darker color
        },
        State {
            name: "pressed"
            when: btnMouse.pressed && button_enable
            PropertyChanges {target: btnRect; color: Qt.darker(background_color, 1.6); scale: 1.03}      //change to darker color
        }
    ]

    transitions:  Transition {
            to: "*"
            reversible: true
            ColorAnimation {duration: 100}
            PropertyAnimation {property: "scale"; duration: 100}
        }
}
