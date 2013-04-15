
import QtQuick 2.0

Item {
    id: root

    property alias enabled: mouseArea.enabled
    property alias imageSource: image.source

    property bool checkable: false
    property bool checked: false
    property alias hover: mouseArea.containsMouse
    property alias pressed: mouseArea.pressed

    opacity: enabled ? 1.0 : 0.3
    signal clicked

    width: image.width
    height: image.height

    Image {
        id: image
        anchors.centerIn: parent
        visible: true
        opacity: pressed ? 0.6 : 1
        smooth: true
    }

//    ColorOverlay {
//        id: glowEffect
//        anchors.fill: image
//        source: image
//        color: pressed ? "#22000000" : checked ? "orange" : "white"
//        visible: checked || hover || pressed
//    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: root
        onPositionChanged: applicationWindow.resetTimer()
        onClicked: root.clicked();
    }
}
