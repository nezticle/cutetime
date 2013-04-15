
import QtQuick 2.0

Row {
    id: root
    spacing: 26
    height: playButton.height

    property bool isPlaybackEnabled: false
    property bool isPlaying: false

    signal forwardButtonPressed()
    signal reverseButtonPressed()
    signal playButtonPressed()
    signal stopButtonPressed()

    //Playback Controls
    ImageButton {
        id: rateReverseButton
        enabled: isPlaybackEnabled
        imageSource: "images/RateButtonReverse.png"
        anchors.verticalCenter: root.verticalCenter
        onClicked: {
            reverseButtonPressed();
        }
    }
    ImageButton {
        id: playButton
        enabled: isPlaybackEnabled
        imageSource: !isPlaying ? "images/PlayButton.png" : "images/PauseButton.png"
        anchors.verticalCenter: root.verticalCenter
//        anchors.right: rateForwardButton.left
//        anchors.rightMargin: 10
        onClicked: {
            playButtonPressed();
        }
    }
//    Rectangle{
//        enabled: isPlaybackEnabled
//        color: "white"
//        opacity: enabled ? 1 : 0.3
//        width: playButton.width
//        height: width
//        anchors.verticalCenter: root.verticalCenter
//        MouseArea {
//            anchors.fill: parent
//            onClicked: stopButtonPressed();
//        }
//    }

    ImageButton {
        id: rateForwardButton
        enabled: isPlaybackEnabled
        imageSource: "images/RateButtonForward.png"
        anchors.verticalCenter: root.verticalCenter
        onClicked: {
            forwardButtonPressed();
        }
    }
}
