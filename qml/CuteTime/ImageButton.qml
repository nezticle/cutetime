
import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias enabled: mouseArea.enabled
    property alias imageSource: image.source

    property bool isToggleable: false
    property bool isChecked: false
    property bool hover: mouseArea.containsMouse
    property bool pressed: mouseArea.pressed

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
        color: "white"
        visible: hover
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true
        anchors.fill: root
        onClicked: {
            root.clicked();
        }
    }
}
