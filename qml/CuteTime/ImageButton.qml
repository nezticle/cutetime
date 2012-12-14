
import QtQuick 2.0

Item {
    id: root

    property alias enabled: mouseArea.enabled
    property alias imageSource: image.source

    signal clicked

    width: image.width
    height: image.height

    Image {
        id: image
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root
        onClicked: {
            root.clicked();
        }
    }

}
