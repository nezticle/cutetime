
import QtQuick 2.0

Item {
    id: root
    height: 30
    width: 120

    property real playbackRate: 0.0

    //Playback Controls
    ImageButton {
        id: rateReverseButton
        imageSource: "images/ratebuttonreverse.png"
        width: 36
        height: 22
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left;
        onClicked: {
            if (playbackRate >= 0.0)
                playbackRate = -1.0;
            else
                playbackRate *= 2 //twice as slow
        }
    }
    ImageButton {
        id: playButton
        imageSource: playbackRate != 1.0 ? "images/playbutton.png" : "images/pausebutton.png"
        width: 26
        height: 30
        anchors.centerIn: root
        onClicked: {
            if (playbackRate == 1.0)
                playbackRate = 0.0;
            else
                playbackRate = 1.0;
        }
    }
    ImageButton {
        id: rateForwardButton
        imageSource: "images/ratebuttonforward.png"
        width: 36
        height: 22
        anchors.verticalCenter: root.verticalCenter
        anchors.right: root.right
        onClicked: {
            if (playbackRate <= 0.0)
                playbackRate = 2.0
            else
                playbackRate *= 2;
        }

    }
}
