
import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias enabled: mouseArea.enabled
    property alias imageSource: image.source

    property bool checkable: false
    property bool checked: false
    property alias hover: mouseArea.containsMouse
    property alias pressed: mouseArea.pressed

    opacity: enabled ? 1.0 : 0.5
    signal clicked

    width: image.width
    height: 24

    Image {
        id: image
        anchors.verticalCenter: parent.verticalCenter
        visible: true
    }

    ColorOverlay {
        id: glowEffect
        anchors.fill: image
        source: image
        color: pressed ? "#22000000" : checked ? "orange" : "white"
        visible: checked || hover || pressed
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: root
        onPositionChanged: applicationWindow.resetTimer()
        onClicked: {
            root.clicked();
            if (checkable)
                checked = !checked
        }
    }
}
