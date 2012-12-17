import QtQuick 2.0

Image {
    id: root
    source: "images/pattern.png"
    fillMode: Image.Tile

    Image {
        anchors.fill: parent
        source: "images/gradient.png"
    }

    Image {
        id: logo
        anchors.centerIn: root
        anchors.verticalCenterOffset: -40
        source: "images/qt-logo.png"
        opacity: 0.5

    }
    Text {
        anchors.top: logo.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#44ffffff"
        text: "No file loaded"
        font.bold: true
        font.pixelSize: 18
    }
}
