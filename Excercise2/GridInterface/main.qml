import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Shapes 1.3
import CustomQmlEnum 1.0
import CustomListModel 1.0

Window {
    id: mainWindow
    width: 800
    height: 600
    visible: true
    title: "Have fun with boxes"

    //property
    property string color_gradient_start: "#121C29"
    property string color_gradient_end: "#1F3347"
    property int selectedBoxType: 0
    property string selectedBoxColor: "green"
    property int selectedBoxValue: 10
    property int timerCount: 0

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

    //Grid with Flickable
    Rectangle {
        id: rectGrid
        width: 500
        height: 500
        color: "#243953"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 50
        anchors.topMargin: 50

        Flickable {
            id: flickable
            anchors.fill: parent
            contentWidth: boxgrid.width
            contentHeight: 123*Math.ceil(myList.count/4)
            clip: true
            bottomMargin: 50

            Grid {
                id: boxgrid
                anchors.fill: parent
                topPadding: 5
                leftPadding: 5
                columns: 4
                spacing: 8

                add: Transition {
                    PropertyAnimation { properties: "x,y"; duration: 100}
                }
                Repeater {
                    model: myList
                    delegate: MyBoxes {
                        boxType: bType
                        boxColor: bColor
                        boxValue: bValue
                    }
                }
            }

            ListModel {
                id: myList
            }
//            MyListModel {
//                id: myList
//            }
        }
    }

    //select box shape
    ComboBox {
        id: cbBox
        x: 610
        y: 50
        width: 150
        currentIndex: selectedBoxType
        model: [ "BOX", "CIRCLE", "TRIANGLE" ]
        onActivated: selectedBoxType = currentIndex
        enabled: true
    }

    //button
    MyButton {
        id: btnGenerate
        x: 610
        y: 288
        width: 150
        height: 52
        text_font: 16
        button_text: "Generate"
        onButtonPressed: {
            cbBox.enabled = false
            btnGenerate.button_enable = false
            timer.start()
        }

        Timer {
            id: timer
            interval: 50
            repeat: true
            onTriggered: {
                selectedBoxType = Math.random()*3
                selectedBoxColor = Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                selectedBoxValue = Math.random()*100
                timerCount++
                if(timerCount > 1000 / interval)
                {
                    cbBox.enabled = true
                    btnGenerate.button_enable = true
                    timerCount = 0
                    timer.stop()
                }
            }
        }
    }
    MyButton {
        id: btnCpp
        x: 610
        y: 357
        width: 150
        height: 52
        button_text: "Add by Cpp"
        text_font: 16
        onButtonClicked: {
            myList.addItem(selectedBoxType, selectedBoxColor, selectedBoxValue)
            if(myList.count > 16)
                flickable.contentY = 123*Math.ceil((myList.count - 16)/4) + 5;
            else
                flickable.contentY = 0
        }
    }
    MyButton {
        id: btnQml
        x: 610
        y: 428
        width: 150
        height: 52
        button_text: "Add by Qml"
        text_font: 16
        onButtonClicked: {
//            myList.append({ bType: selectedBoxType, bColor: selectedBoxColor, bValue: selectedBoxValue})
            if(myList.count > 16)
                flickable.contentY = 123*Math.ceil((myList.count - 16)/4) + 5;
            else
                flickable.contentY = 0
        }
    }
    MyButton {
        id: btnClear
        x: 610
        y: 498
        width: 150
        height: 52
        button_text: "Clear"
        text_font: 16
        onButtonClicked: {
            myList.clearList()
            listModelShape.clear()
        }
    }

    //load sample shape
    function loadSampleShape() {
        sampleShapeLoader.sourceComponent = undefined
        sampleShapeLoader.sourceComponent = compBoxShape
    }
    Loader {
        id: sampleShapeLoader
        x: 610
        y: 114
        width: 150
        height: width
    }
    Component {
        id: compBoxShape
        MyBoxes {
            id: box
            boxType: selectedBoxType
            boxColor: selectedBoxColor
            boxValue: selectedBoxValue
        }
    }

    onSelectedBoxTypeChanged: loadSampleShape()
    Component.onCompleted: loadSampleShape()
}
