
import QtQuick 2.0

Item {
    id: root
    width: 100
    height: volumeUp.height

    property alias volume: volumeSlider.value

    //Volume Controls
    ImageButton {
        id: volumeDown
        imageSource: "images/VolumeDown.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left
        onClicked: {
            root.volume = 0.0;
        }
    }
    VolumeSlider {
        id: volumeSlider
        anchors.left: volumeDown.right
        anchors.leftMargin: 3
        anchors.rightMargin: 5
        anchors.right: volumeUp.left
        maximum: 1.0
        minimum: 0.0
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: 1
    }

    ImageButton {
        id: volumeUp
        imageSource: "images/VolumeUp.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: 1
        anchors.right: root.right
        onClicked: {
            root.volume = 1.0
        }
    }
}
