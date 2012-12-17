import QtQuick 2.0

Rectangle {
    id: root
    height: 50
    signal urlAccepted(string text)
    color: "#cc222222"
    Behavior on opacity { NumberAnimation{} }
    onOpacityChanged: if (opacity == 1) urlInput.forceActiveFocus();

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
    }

    BorderImage {
        id: urlBar
        source: "images/ControlBar.png"
        border.top: 12
        border.bottom: 12
        border.left: 12
        border.right: 12
        height: 58
        anchors.centerIn: parent
        width: controlBar.width

        Rectangle {
            anchors.fill: parent
            anchors.margins: 16
            color: "#66ffffff"
            border.color: "#bbffffff"
            radius: 2
            antialiasing: true

            TextInput {
                id: urlInput
                clip: true
                selectionColor: "#aaffffff"
                selectedTextColor: "black"
                selectByMouse: true
                anchors.fill: parent
                font.pointSize: 16
                anchors.margins: 5
                color: "black"
                text: "http://"
                onAccepted: root.urlAccepted(urlInput.text);
            }
        }
    }
}
