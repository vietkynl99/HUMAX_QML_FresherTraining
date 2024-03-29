import QtQuick 2.12
import QtQuick.Window 2.12
import CustomQmlEnum 1.0

Window {
    id: root
    width: 360
    height: 640
    visible: true
    title: qsTr("Flappy Bird")

    property int score: 0
    property int pipe_distance_space: 200
    property int pipe_distance: 250     //distance between 2 pipe
    property int game_status: EnumStatus.HOME
    property int game_level: 0      //0:easy   1:medium    2:hard
    property int game_speed: 7000
    property real game_speed_dec: 0
    property int level0: 330
    property int level: level0
    property int t: 0
    property int vt: 10
    property real at: -0.5
    property int delta: 3
    property string cheat_code: ""

    function processHandler()
    {
        if(game_status === EnumStatus.RUNNING)
        {
            level0 = level
            t = 0
        }
        else if(game_status === EnumStatus.START)
        {
            gameStart()
        }
    }
    function gameOver()
    {
        game_status = EnumStatus.STOP
    }
    function gameStart()
    {
        resetInitialValue()
        game_status = EnumStatus.RUNNING
    }
    function gameReset()
    {
        cheat_code=""
        resetInitialValue()
        game_status= EnumStatus.START
        loaderId.sourceComponent = undefined
        loaderId.sourceComponent = comId
    }
    function resetInitialValue()
    {
        switch(game_level)
        {
        case 0:
            pipe_distance_space = 200
            pipe_distance = 280
            game_speed = 6000
            vt = 10
            at = -0.5
            break
        case 1:
            pipe_distance_space = 150
            pipe_distance = 250
            game_speed = 5000
            vt = 12
            at = -0.7
            break
        default:
            pipe_distance_space = 150
            pipe_distance = 250
            game_speed = 4000
            vt = 14
            at = -1
            break
        }
        game_speed_dec = 0
        t = 0
        score = 0
        level0 = mainItem.height/2
        level = level0
        bird.rotation = 0
        myList.set(0, {"alt": mainItem.height, "dis": mainItem.height})
        myList.set(1, {"alt": mainItem.height*0.6, "dis": pipe_distance_space})
        for(var i=2; i<myList.count-2; i++)
            myList.set(i, {"alt": Math.random()*mainItem.height*0.63+mainItem.height*0.23, "dis": pipe_distance_space})
    }
    function showInfo()
    {
        switch(game_level)
        {
        case 0:
            return "EASY - SCORE: " + score
        case 1:
            return "MEDIUM - SCORE: " + score
        default:
            return "HARD - SCORE: " + score
        }
    }


    Item {
        id: mainItem
        width: 360
        height: 640
        anchors.centerIn: parent
        scale: Math.min(root.width/width, root.height/height)
        clip: true

        Image {
            anchors.fill: parent
            source: "image/background.png"
        }

        Item {
            id: mainpage
            anchors.fill: parent
            clip: true
            focus: true

            ListModel {
                id: myList
                ListElement {alt: 640; dis: 150}
                ListElement {alt: 350; dis: 150}
                ListElement {alt: 250; dis: 150}
                ListElement {alt: 280; dis: 150}
                ListElement {alt: 640; dis: 150}
                ListElement {alt: 350; dis: 150}
            }

            Loader {
                id: loaderId
                anchors.fill: parent
                sourceComponent: comId
            }

            Component {
                id: comId
                Repeater {
                    model: myList
                    PipeMap {
                        x: index * pipe_distance
                        altitude: alt
                        distance: dis

                        NumberAnimation on x {
                            from: index * pipe_distance
                            to: (-myList.count + index + 2) * pipe_distance
                            loops: Animation.Infinite
                            duration: game_speed //- game_speed_dec
                            running: game_status == EnumStatus.RUNNING
                        }
                        onXChanged: {
                            if(checkInvalid(bird.x + delta, bird.y+delta) || checkInvalid(bird.x + bird.width - delta, bird.y+delta) ||
                                    checkInvalid(bird.x + delta, bird.y + bird.height - delta) || checkInvalid(bird.x + bird.width - delta, bird.y + bird.height - delta))
                            {
                                if(cheat_code !== "12123434")
                                    gameOver()
                            }
                            if(x>-pipe_distance - 50 && x<-pipe_distance && index < myList.count - 2)
                            {
                                myList.set(index, {"alt": Math.random()*400+150, "dis": pipe_distance_space})
                            }
                            if(index >= myList.count - 2)
                            {
                                myList.set(index, {"alt": myList.get(index - myList.count + 2).alt, "dis": pipe_distance_space})
                            }
                        }
                    }

                }
            }

            Image {
                id: bird
                x: width/4
                y: level
                width: 55
                height: 35
                fillMode: Image.Stretch
                source: "image/bird.png"
            }
            Text {
                id: txtScore
                x: 5
                y: 3
                color: "white"
                text: showInfo()
                font.bold: true
                font.pointSize: 12
                visible: game_status !== EnumStatus.HOME
            }
            Text {
                id: txtStatus
                color: "white"
                text: "START"
                font.bold: true
                font.pointSize: 24
                anchors.centerIn: parent
                visible: false

                states: [
                    State {
                        name: "start"
                        when: game_status === EnumStatus.START
                        PropertyChanges {target: txtStatus; text: "START"; visible:true}
                    },
                    State {
                        name: "running"
                        when: game_status === EnumStatus.RUNNING
                        PropertyChanges {target: txtStatus; visible:false}
                    },
                    State {
                        name: "gameover"
                        when: game_status === EnumStatus.STOP
                        PropertyChanges {target: txtStatus; text: "GÀ"; visible:true}
                    }
                ]
            }

            states: State {
                when: game_status == EnumStatus.HOME
                PropertyChanges {target: mainpage; opacity: 0}
            }
            transitions: Transition {
                to: ""
                PropertyAnimation {property: "opacity"; duration: 300}
            }

            Keys.onPressed: {
                if(cheat_code.length<8)
                    cheat_code += String.fromCharCode(event.key).toUpperCase()
            }

            MouseArea {
                anchors.fill: parent
                onPressed: processHandler()
            }

            Timer {
                id: timer
                interval: 25
                repeat: true
                running: game_status == EnumStatus.RUNNING
                onTriggered: {
                    score++
                    t++;
                    var y = level0 - vt*t - at*t*t
                    if( y < -bird.height)
                    {
                        level = -bird.height
                    }
                    else if( y > root.height)
                    {
                        level = root.height
                        gameOver()
                    }
                    else
                    {
                        level = y
                    }
                    bird.rotation = -7*(vt+at*t)


                    //                    if(game_speed_dec<4000)
                    //                    {
                    //                        game_speed_dec = score*5;
                    //                    }
                }
            }


            MyButton {
                x: 29
                width: 200
                height: 40
                anchors.top: parent.top
                text_color: "white"
                border_width: 1
                background_color: "#55A901"
                anchors.topMargin: 400
                anchors.horizontalCenter: parent.horizontalCenter
                text_font: 14
                button_text: "PLAY AGAIN"
                visible: game_status == EnumStatus.STOP
                onButtonClicked: game_status = EnumStatus.HOME
            }
        }

        Item {
            id: homepage
            anchors.fill: parent
            visible: game_status == EnumStatus.HOME

            MyButton {
                x: 29
                width: 200
                height: 40
                anchors.top: parent.top
                anchors.horizontalCenterOffset: 0
                text_color: "white"
                border_width: 1
                background_color: "#55A901"
                anchors.topMargin: 240
                anchors.horizontalCenter: parent.horizontalCenter
                text_font: 14
                button_text: "EASY"
                onButtonClicked: {
                    game_level = 0
                    gameReset()
                }
            }
            MyButton {
                x: 29
                width: 200
                height: 40
                anchors.top: parent.top
                button_text: "MEDIUM "
                anchors.horizontalCenterOffset: 0
                anchors.topMargin: 310
                anchors.horizontalCenter: parent.horizontalCenter
                background_color: "#55A901"
                text_color: "white"
                text_font: 14
                border_width: 1
                onButtonClicked: {
                    game_level = 1
                    gameReset()
                }
            }
            MyButton {
                x: 29
                width: 200
                height: 40
                anchors.top: parent.top
                button_text: "HARD "
                anchors.horizontalCenterOffset: 0
                anchors.topMargin: 380
                anchors.horizontalCenter: parent.horizontalCenter
                background_color: "#55A901"
                text_color: "white"
                text_font: 14
                border_width: 1
                onButtonClicked: {
                    game_level = 2
                    gameReset()
                }
            }

            Text {
                id: txtGame
                color: "#ffffff"
                text: qsTr("FLAPPY BIRD")
                anchors.top: parent.top
                font.pixelSize: 34
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.italic: false
                anchors.topMargin: 120
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter

                SequentialAnimation {
                    running: true
                    loops: Animation.Infinite

                    PauseAnimation {duration: 500}
                    NumberAnimation {
                        target: txtGame
                        property: "rotation"
                        alwaysRunToEnd: true
                        duration: 200
                        easing.type: Easing.InOutQuad
                        to: 5
                    }
                    NumberAnimation {
                        target: txtGame
                        property: "rotation"
                        alwaysRunToEnd: true
                        duration: 200
                        easing.type: Easing.InOutQuad
                        to: -5
                    }
                    NumberAnimation {
                        target: txtGame
                        property: "rotation"
                        alwaysRunToEnd: true
                        duration: 200
                        easing.type: Easing.InOutQuad
                        to: 0
                    }
                    PauseAnimation {duration: 3000}
                }
            }
        }
        Text {
            color: "#ffffff"
            text: qsTr("Viet Kynl")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 5
            anchors.rightMargin: 10
            font.weight: Font.ExtraLight
            font.italic: true
        }

        Component.onCompleted: resetInitialValue()
    }
}
