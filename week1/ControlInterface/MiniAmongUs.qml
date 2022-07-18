import QtQuick 2.0

Item {
    id: root
    width: 100
    height: width
    property int rectMainWidth: 800
    property int rectMainHeight: 800
    property bool motion_enable: true

//    Image {
//        id: img
//        anchors.fill: parent
//        source: "image/amongus_yellow.png"
//        fillMode: Image.PreserveAspectFit
//        smooth: true
//    }
    AnimatedImage {
        anchors.fill: parent
        source: "image/amongus_run2.gif"
        fillMode: Image.PreserveAspectFit
        playing: true
    }

    ParallelAnimation {
        id: motion
        alwaysRunToEnd: true
        running: true
        NumberAnimation {
            id: animaX
            target: root
            property: "x"
            alwaysRunToEnd: true
            to: Math.random()*810
            duration: Math.abs(to*10)
        }
        NumberAnimation {
            id: animaY
            target: root
            property: "y"
            alwaysRunToEnd: true
            to: Math.random()*560
            duration: Math.abs(to*10)
        }
        onRunningChanged: {
            if(!motion.running && motion_enable)
            {
                motion.start()
                animaX.to = Math.random()*810
                animaY.to = Math.random()*560
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        drag.target: parent
        drag.axis: Drag.XAndYAxis
        drag.minimumX: 0
        drag.maximumX: rectMainWidth - root.width
        drag.minimumY: 0
        drag.maximumY: rectMainHeight - root.height
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onPressed: {
            if(mouse.button === Qt.LeftButton)
            {
                motion_enable = false
                motion.stop()
            }
            else
                root.destroy()
        }
        onReleased: {
            if(mouse.button === Qt.LeftButton)
            {
                motion_enable = true
                motion.start()
            }
        }
    }
}
