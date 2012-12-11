
import QtQuick 2.0

Item {
    id: root

    property alias enabled: mouseArea.enabled
    property alias imageSource: image.source

    signal clicked

    Image {
        id: image
        anchors.fill: root
    }

    MouseArea {
        id: mouseArea
        anchors.fill: root
        onClicked: {
            root.clicked();
        }
    }

}
