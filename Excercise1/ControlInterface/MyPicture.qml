import QtQuick 2.0
import QtQuick.Dialogs 1.1

Item {
    id: itemPic
    width: 910
    height: 660
    property real pic_scale: Math.min(pic.width/pic.sourceSize.width, pic.height/pic.sourceSize.height)
    property real pic_width: pic.sourceSize.width * pic_scale
    property real pic_height: pic.sourceSize.height * pic_scale

    AnimatedImage {
        id: pic
        width: 600
        height: 400
        anchors.verticalCenter: parent.verticalCenter
        source: "image/meme.gif"
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        playing: false
    }
    Rectangle {
        width: pic.width
        height: 8
        opacity: 0.7
        color: "#c7c2c2"
        x: pic.x
        y: pic.y + pic.height/2 + pic_height / 2
    }
    Rectangle {
        width: 4
        height: 8
        color: "white"
        x: pic.x + pic.width*pic.currentFrame/pic.frameCount
        y: pic.y + pic.height/2 + pic_height / 2
    }

    MyButton {
        x: 276
        y: 567
        width: 104
        height: 40
        text_font: 12
        button_text: "Start"
        onButtonClicked: pic.playing = true
    }
    MyButton {
        x: 392
        y: 567
        width: 104
        height: 40
        text_font: 12
        button_text: "Pause"
        onButtonClicked: pic.playing = false
    }
    MyButton {
        x: 510
        y: 567
        width: 104
        height: 40
        text_font: 12
        button_text: "Stop"
        onButtonClicked: {pic.playing = false; pic.currentFrame = 0}
    }


}
