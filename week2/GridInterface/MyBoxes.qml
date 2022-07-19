import QtQuick 2.0
import QtQuick.Shapes 1.3
import CustomQmlEnum 1.0

Item {
    width: 115
    height: width

    //property
    property int boxWidth: 115
    property int boxType: 0
    property string boxColor: "blue"
    property int boxValue: 50

    //load when boxtype change
    function loadSelectedBox()
    {
        switch(boxType)
        {
        case 0:
            myLoader.sourceComponent = compBox
            break
        case 1:
            myLoader.sourceComponent = compCircle
            break
        default:
            myLoader.sourceComponent = compTriangle
        }
    }

    Loader {
        id: myLoader
        anchors.centerIn: parent
        width: boxWidth
        height: boxWidth
    }
    Component {
        id: compBox
        Rectangle {
            id: rectCompBox
            width: boxWidth
            height: width
            color: boxColor
            radius: 25
            border.width: 3
            Text {
                text: boxValue
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Arial"
                font.pointSize: 40
                color: "black"
            }
        }
    }
    Component {
        id: compCircle
        Rectangle {
            width: boxWidth
            height: width
            color: boxColor
            radius: width/2
            border.width: 3
            Text {
                text: boxValue
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Arial"
                font.pointSize: 40
                color: "black"
            }
        }
    }
    Component {
        id: compTriangle
        Shape {
            id: shapeBox
            width: boxWidth
            height: width
            anchors.centerIn: parent
            ShapePath {
                strokeWidth: 3
                strokeColor: "black"
                fillColor: boxColor
                startX: shapeBox.width/2
                startY: 0
                PathLine { x: shapeBox.width; y: shapeBox.height }
                PathLine { x: 0; y: shapeBox.height }
                PathLine { x: shapeBox.width/2; y: 0 }
            }
            Text {
                text: boxValue
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.bottomMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Arial"
                font.pointSize: 40
                color: "black"
            }
        }
    }

    Component.onCompleted: loadSelectedBox()
}
