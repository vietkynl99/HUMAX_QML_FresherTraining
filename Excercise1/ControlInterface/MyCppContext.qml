import QtQuick 2.0

Item {
    width: 350
    height: 300

        Text {
            x: 73
            y: 102
            width: 164
            height: 20
            text: "myvalue: " + MyData.myvalue.toString()
            font.pixelSize: 14
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        TextInput{
            x: 73
            y: 79
            width: 164
            height: 20
            text: "0"
            color: "white"
            cursorVisible: true
            font.pixelSize: 14
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            selectByMouse: true
            focus: true

            Keys.onEnterPressed: {
                if(text != "")
                {
                    var value = parseInt(text, 10);
                    if(value !== NaN && value > -2147483648 && value < 2147483647)
                    {
                        MyData.myvalue = value;
                    }
                    text = ""
                }
            }
        }
        MyButton{
            x: 118
            y: 136
            height: 30
            width: 75
            text_font: 16
            button_text: "set 100"
            background_color: "#30597E"
            onButtonClicked: MyData.callSet(100)
        }
        MyButton {
            x: 118
            y: 177
            width: 75
            height: 30
            text_font: 16
            button_text: "reset"
            background_color: "#30597E"
            onButtonClicked: MyData.callReset()
        }

}
