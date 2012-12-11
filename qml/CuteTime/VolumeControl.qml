
import QtQuick 2.0

Item {
    id: root
    width: 150
    height: 30

    property alias volume: volumeSlider.value

    //Volume Controls
    ImageButton {
        id: volumeDown
        imageSource: "images/volumedown.png"
        width: 19
        height: 20
        anchors.verticalCenter: root.verticalCenter
        anchors.right: volumeSlider.left
        anchors.rightMargin: 5
        onClicked: {
            root.volume = 0.0;
        }
    }
    VolumeSlider {
        id: volumeSlider
        height: 12
        width: 80
        maximum: 1.0
        minimum: 0.0
        anchors.centerIn: root

    }

    ImageButton {
        id: volumeUp
        imageSource: "images/volumeup.png"
        width: 25
        height: 25
        anchors.verticalCenter: root.verticalCenter
        anchors.left: volumeSlider.right
        anchors.leftMargin: 5
        onClicked: {
            root.volume = 1.0
        }
    }
}
