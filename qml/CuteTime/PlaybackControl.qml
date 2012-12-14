
import QtQuick 2.0

Item {
    id: root
    width: 120
    height: playButton.height

    property real playbackRate: 0.0
    property bool playbackEnabled: false

    //Playback Controls
    ImageButton {
        id: rateReverseButton
        imageSource: "images/ratebuttonreverse.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left;
        onClicked: {
            if (playbackEnabled) {
                if (playbackRate >= 0.0)
                    playbackRate = -1.0;
                else
                    playbackRate *= 2 //twice as slow
            }
        }
    }
    ImageButton {
        id: playButton
        imageSource: playbackRate != 1.0 ? "images/playbutton.png" : "images/pausebutton.png"
        anchors.centerIn: root
        anchors.horizontalCenterOffset: 2
        onClicked: {
            if (playbackEnabled) {
                if (playbackRate == 1.0)
                    playbackRate = 0.0;
                else
                    playbackRate = 1.0;
            }
        }
    }
    ImageButton {
        id: rateForwardButton
        imageSource: "images/ratebuttonforward.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.right: root.right
        onClicked: {
            if (playbackEnabled) {
                if (playbackRate <= 0.0)
                    playbackRate = 2.0
                else
                    playbackRate *= 2;
            }
        }

    }
}
