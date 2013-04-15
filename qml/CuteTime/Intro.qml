import QtQuick 2.0

Rectangle {
    id: root
    color: "#111111"

//    Image {
//        anchors.fill: parent
//        source: "images/gradient.png"
//    }

    Image {
        id: logo
        anchors.centerIn: root
        anchors.verticalCenterOffset: -60
        source: "images/qt-logo.png"
        opacity: 0.5

    }
//    Rectangle {
//        id: button
//        opacity: mouse.containsMouse ? 1 : 0
//        Behavior on opacity {NumberAnimation{duration: 100}}
//        color: mouse.pressed ? "#11000000" : "#11ffffff"
//        anchors.top: logo.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//        border.color: "#33ffffff"
//        width: text.width + 40
//        height: text.height + 4
//        antialiasing: true
//        radius: 4
//        MouseArea {
//            id: mouse
//            anchors.fill: parent
//            hoverEnabled: true
//            onClicked: applicationWindow.openVideo()
//        }
//    }

//    Text {
//        id: text
//        color: "#44ffffff"
//        text: "Open File"
//        font.bold: true
//        font.pixelSize: 18
//        anchors.centerIn: button
//    }
}
