import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: root
    width: 170
    height: 500
    property int buttonHeight: 50
    property int textFontSize: 16
    property string backgroundColor: "black"
    property string pressColor: "green"
    signal itemSelected(int idx)

    ListModel {
        id: menuModel
        ListElement { name: "Menu 1" }
        ListElement { name: "Menu 2" }
        ListElement { name: "Menu 3" }
        ListElement { name: "Menu 4" }
        ListElement { name: "Menu 5" }
    }

    ListView {
        id: menuListView
        anchors.fill: parent
        boundsBehavior : Flickable.StopAtBounds
        currentIndex: 0
        interactive: false
        model: menuModel

        delegate: MyButton {
            id: btnMenu
            width: root.width
            height: buttonHeight
            button_text: name
            text_font: textFontSize
            background_color: backgroundColor
            onButtonPressed: {
                menuListView.currentIndex = index
                itemSelected(index)
                btnMenu.background_color = backgroundColor
            }
        }
        //default menu is 0
        Component.onCompleted: {
            menuListView.currentIndex = 0
            itemSelected(0)
        }
    }
}
