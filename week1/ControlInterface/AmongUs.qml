import QtQuick 2.0
import QtMultimedia 5.0

Item {
    id: myItem
    width: 910
    height: 660
    property int knife_rot_initial: 60
    property int knife_y_initial: 440
    property int amongus_green_initialX: 0
    property int para_animation_duration: 600

    Image {
        id: imgAmongUs_die
        x: 755
        y: 393
        width: 114
        height: 159
        source: "image/amongus_die.png"
        fillMode: Image.PreserveAspectFit
        visible: false
    }
    Image {
        id: imgAmongUs_green
        x: amongus_green_initialX
        y: 349
        width: 199
        height: 180
        source: "image/amongus_green.png"
        fillMode: Image.PreserveAspectFit
    }
    Image {
        id: img_knife
        x: imgAmongUs_green.x + 140
        y: knife_y_initial
        width: 67
        height: 64
        source: "image/knife.png"
        rotation: knife_rot_initial
        fillMode: Image.PreserveAspectFit


    }

    SequentialAnimation {
        id: sqAnimation
        //move AmongUs green
        ParallelAnimation {
            id: paraAnimation
            alwaysRunToEnd: true

            NumberAnimation {
                target: imgAmongUs_green
                alwaysRunToEnd: true
                property: "x"
                to: imgAmongUs_red.x - 180
                duration: para_animation_duration
                //                easing.bezierCurve: [0.211,0.86,0.174,0.999,1,1]
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                target: img_knife
                property: "rotation"
                alwaysRunToEnd: true
                to: 0
                easing.type: Easing.OutQuart
                duration: para_animation_duration
            }
            NumberAnimation {
                target: img_knife
                property: "y"
                easing.type: Easing.OutQuart
                alwaysRunToEnd: true
                to: knife_y_initial - 95
                duration: para_animation_duration
            }
        }

        //move knife down
        ParallelAnimation {
            alwaysRunToEnd: true
            NumberAnimation { target: img_knife; property: "x"; alwaysRunToEnd: true; to: 730; duration: 100}
            NumberAnimation { target: img_knife; property: "y"; alwaysRunToEnd: true; to: knife_y_initial - 65; duration: 100}
        }
        //move knife up
        ParallelAnimation {
            loops: 3
            alwaysRunToEnd: true
            NumberAnimation { target: img_knife; property: "x"; alwaysRunToEnd: true; to: 690; duration: 80}
            NumberAnimation { target: img_knife; property: "y"; alwaysRunToEnd: true; to: knife_y_initial - 85; duration: 70}
        }

        onRunningChanged: {
            if(!running){
                imgAmongUs_red.visible = false
                imgAmongUs_die.visible = true
            }
        }
    }

    MyButton {
        x: 60
        y: 578
        width: 104
        height: 40
        text_font: 12
        button_text: "Animation start"
        onButtonClicked: {
            if(!sqAnimation.running)
            {
                imgAmongUs_green.x = 77
                sqAnimation.start()
                playSound.play()
            }
        }
    }
    MyButton {
        x: 184
        y: 578
        width: 104
        height: 40
        button_text: "Animation reset"
        text_font: 12
        onButtonClicked: {
            if(!sqAnimation.running)
            {
                imgAmongUs_red.visible = true
                imgAmongUs_die.visible = false
                imgAmongUs_green.x = amongus_green_initialX
                img_knife.rotation = knife_rot_initial
                img_knife.y = knife_y_initial
            }
        }
    }

    SoundEffect {
        id: playSound
        source: "soundeffect/amongus_sound.wav"
    }

    Flickable {
        id: flickable
        width: parent.width
        height: 550
        contentWidth: imgAmongUs_red.width; contentHeight: imgAmongUs_red.height

        Image {
            id: imgAmongUs_red
            x: 744
            y: 370
            width: 114
            height: 159
            source: "image/amongus_red.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    MyButton {
        x: 309
        y: 578
        width: 104
        height: 40
        text_font: 12
        button_text: "Generator"

        onButtonClicked: {
            var obj = createObjects("MiniAmongUs.qml", Math.random()*(myItem.width - 100), Math.random()*(myItem.height - 100))
            obj.rectMainWidth = myItem.width
            obj.rectMainHeight = myItem.height
        }
    }



    function createObjects(qmlComp, positionX, positionY)
    {
        var comp = Qt.createComponent(qmlComp);
        if (comp.status === Component.Ready)
        {
            var obj = comp.createObject(myItem, {x: positionX, y: positionY});
            if (obj === null)
                console.log("Error creating object");
            else
                return obj
        }
        else
            console.log("Error loading component:", comp.errorString());
        return null
    }




}
