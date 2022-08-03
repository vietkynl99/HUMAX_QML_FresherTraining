import QtQuick 2.0

Item {
    id: root
    x: startX
    y: 0
    width: 100
    height: 640
    clip: true

    property int distance: 150
    property int altitude: 250

    function checkInvalid(posX, posY)
    {
        return posX > root.x && posX < root.x + root.width && (posY > altitude || posY < altitude - distance)
    }

    Image {
        y: altitude
        width: root.width
        height: root.height
        source: "image/pipe.png"
    }

    Image {
        y: altitude - root.height - distance
        width: root.width
        height: root.height
        rotation: 180
        source: "image/pipe.png"
    }


}
