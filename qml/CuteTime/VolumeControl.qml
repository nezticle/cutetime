
import QtQuick 2.0

Item {
    id: root
    width: 210
    height: volumeUp.height

    property alias volume: volumeSlider.value

    //Volume Controls
    ImageButton {
        id: volumeDown
        imageSource: "images/VolumeDown.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left
        scale: 1.4
        onClicked: {
            root.volume = 0.0;
        }
    }
    Slider {
        id: volumeSlider
        anchors.left: volumeDown.right
        anchors.leftMargin: 22
        anchors.rightMargin: 22
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
        scale: 1.4
        onClicked: {
            root.volume = 1.0
        }
    }
}
