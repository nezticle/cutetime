import QtQuick 2.0

Rectangle {
    id: root
    height: 50
    signal urlAccepted(string text)
    color: "#cc222222"
    Behavior on opacity { NumberAnimation{} }
    onOpacityChanged: {
        if (opacity == 1)
            urlInput.focus = true
        else if (opacity == 0)
            urlInput.focus = false
    }

    Keys.onEscapePressed: root.opacity = 0

    MouseArea {
        anchors.fill: parent
        onClicked: root.opacity = 0
    }

    Text {
        anchors.bottom: urlBar.top
        anchors.left: urlBar.left
        anchors.bottomMargin: 8
        text: "Enter URL"
        color: "white"
        font.pixelSize: 20
    }

    BorderImage {
        id: urlBar
        source: "images/ControlBar.png"
        border.top: 12
        border.bottom: 12
        border.left: 12
        border.right: 12
        height: 70
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -170
        width: 600

        Rectangle {
            anchors.fill: parent
            anchors.margins: 16
            color: "#66ffffff"
            border.color: "#bbffffff"
            radius: 2
            antialiasing: true

            TextInput {
                id: urlInput
                selectionColor: "#aaffffff"
                selectedTextColor: "black"
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 5
                font.pixelSize: 24
                color: "black"
                text: "http://"
                onAccepted: root.urlAccepted(urlInput.text);

            }
        }
    }

//    Rectangle {
//        anchors.right: urlBar.left
//        anchors.rightMargin: 32
//        anchors.verticalCenter: urlBar.verticalCenter
//        height: 70
//        width: 70
//        color: "gray"
//        MouseArea {
//            anchors.fill: parent
//            onClicked: { urlInput.text = ""; urlInput.paste(); }
//        }
//    }
}
