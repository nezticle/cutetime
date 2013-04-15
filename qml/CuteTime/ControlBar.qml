
import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    id: controlBar
    height: 150
    color: "#88333333"

    property MediaPlayer mediaPlayer: null
    property bool isMouseAbove: false

    signal openFile()
    signal openCamera()
    signal openURL()
    signal openFX()
    signal toggleFullScreen()

    state: "VISIBLE"

    onMediaPlayerChanged: {
        if (mediaPlayer === null)
            return;
        volumeControl.volume = mediaPlayer.volume;
    }

//    MouseArea {
//        anchors.fill: controlBar
//        hoverEnabled: true

//        onEntered: controlBar.isMouseAbove = true;
//        onExited: controlBar.isMouseAbove = false;
//    }

    function statusString(stat)
    {
        if (stat === MediaPlayer.NoMedia)
            return "No Media";
        else if (stat === MediaPlayer.Loading)
            return "Loading";
        else if (stat === MediaPlayer.Loaded)
            return "Loaded";
        else if (stat === MediaPlayer.Buffering)
            return "Buffering";
        else if (stat === MediaPlayer.Stalled)
            return "Stalled";
        else if (stat === MediaPlayer.Buffered)
            return "Buffered";
        else if (stat === MediaPlayer.EndOfMedia)
            return "EndOfMedia";
        else if (stat === MediaPlayer.InvalidMedia)
            return "InvalidMedia";
        else if (stat === MediaPlayer.UnknownStatus)
            return "UnknownStatus";
    }

//    Text {
//        id: statusText
//        anchors.left: parent.left
//        anchors.bottom: parent.top
//        anchors.bottomMargin: 12
//        font.pixelSize: 18
//        color: "white"
//        text: "Status: " + statusString(mediaPlayer.status)
//    }

//    Text {
//        anchors.verticalCenter: statusText.verticalCenter
//        anchors.left: statusText.right
//        anchors.leftMargin: 16
//        font.pixelSize: 18
//        color: "white"
//        text: Math.round(mediaPlayer.bufferProgress * 100.0) + "%"
//    }

    VolumeControl {
        id: volumeControl
        anchors.verticalCenter: playbackControl.verticalCenter
        anchors.left: controlBar.left
        anchors.leftMargin: 15
        onVolumeChanged: mediaPlayer.volume = volume

        Component.onCompleted: {
            volumeControl.volume = startingVolume;
        }

        Connections {
            target: mediaPlayer
            onVolumeChanged: volumeControl.volume = mediaPlayer.volume
        }
    }

    //Playback Controls
    PlaybackControl {
        id: playbackControl
        anchors.horizontalCenter: controlBar.horizontalCenter
        anchors.bottom: seekControl.top
        anchors.bottomMargin: 20

        onPlayButtonPressed: {
            if (isPlaying) {
                mediaPlayer.pause();
            } else {
                mediaPlayer.play();
            }
        }

        onReverseButtonPressed: {
            if (mediaPlayer.seekable) {
                //Subtract 10 seconds
                mediaPlayer.seek(normalizeSeek(Math.round(-mediaPlayer.duration * 0.1)));
            }
        }

        onForwardButtonPressed: {
            if (mediaPlayer.seekable) {
                //Add 10 seconds
                mediaPlayer.seek(normalizeSeek(Math.round(mediaPlayer.duration * 0.1)));
            }
        }

        onStopButtonPressed: mediaPlayer.stop();
    }

    //Toolbar Controls
    Row {
        id: toolbarMenuButtons
        anchors.right: controlBar.right
        anchors.rightMargin: 15
        anchors.verticalCenter: playbackControl.verticalCenter
        spacing: 22

        ImageButton {
            id: fxButton
            imageSource: "images/FXButton.png"
            checkable: true
            checked: effectSelectionPanel.visible
            onClicked: {
                openFX();
            }
        }
        ImageButton {
            id: fileButton
            imageSource: "images/FileButton.png"
            onClicked: {
                openFile();
            }
        }
        ImageButton {
            id: urlButton
            imageSource: "images/UrlButton.png"
            onClicked: {
                openURL();
            }
        }
    }

//    ImageButton {
//        id: fullscreenButton
//        imageSource: "images/FullscreenButton.png"
//        onClicked: {
//            //Toggle fullscreen
//            toggleFullScreen();
//        }
//        checkable: true
//        checked: applicationWindow.isFullScreen
//        anchors.right: controlBar.right
//        anchors.top: controlBar.top
//        anchors.rightMargin: 15
//        anchors.topMargin: 15
//    }

    //Seek controls
    SeekControl {
        id: seekControl
        anchors.bottom: controlBar.bottom
        anchors.bottomMargin: 10
        anchors.right: controlBar.right
        anchors.left: controlBar.left
        anchors.rightMargin: 15
        anchors.leftMargin: 15
        enabled: playbackControl.isPlaybackEnabled

        duration: mediaPlayer.duration

        onSeekValueChanged: {
            mediaPlayer.seek(newPosition);
            position = mediaPlayer.position;
        }

        Component.onCompleted: {
            seekable = mediaPlayer.seekable;
        }
    }

    Connections {
        target: mediaPlayer
        onPositionChanged: {
            if (!seekControl.pressed) seekControl.position = mediaPlayer.position;
        }
        onStatusChanged: {
            if ((mediaPlayer.status == MediaPlayer.Loaded) || (mediaPlayer.status == MediaPlayer.Buffered) || mediaPlayer.status === MediaPlayer.Buffering || mediaPlayer.status === MediaPlayer.EndOfMedia)
                playbackControl.isPlaybackEnabled = true;
            else
                playbackControl.isPlaybackEnabled = false;
        }
        onPlaybackStateChanged: {
            if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                playbackControl.isPlaying = true;
                applicationWindow.resetTimer();
            } else {
                show();
                playbackControl.isPlaying = false;
            }
        }

        onSeekableChanged: {
            // console.log("seekableChanged: " + mediaPlayer.seekable);
            seekControl.seekable = mediaPlayer.seekable;
        }
    }

    function hide() {
        controlBar.state = "HIDDEN";
    }

    function show() {
        controlBar.state = "VISIBLE";
    }

    //Usage: give the value you wish to modify position,
    //returns a value between 0 and duration
    function normalizeSeek(value) {
        var newPosition = mediaPlayer.position + value;
        if (newPosition < 0)
            newPosition = 0;
        else if (newPosition > mediaPlayer.duration)
            newPosition = mediaPlayer.duration;
        return newPosition;
    }

    states: [
        State {
            name: "HIDDEN"
            PropertyChanges {
                target: controlBar
                opacity: 0.0
            }
        },
        State {
            name: "VISIBLE"
            PropertyChanges {
                target: controlBar
                opacity: 0.95
            }
        }
    ]

    transitions: [
        Transition {
            from: "HIDDEN"
            to: "VISIBLE"
            NumberAnimation {
                id: showAnimation
                target: controlBar
                properties: "opacity"
                from: 0.0
                to: 1.0
                duration: 200
            }
        },
        Transition {
            from: "VISIBLE"
            to: "HIDDEN"
            NumberAnimation {
                id: hideAnimation
                target: controlBar
                properties: "opacity"
                from: 0.95
                to: 0.0
                duration: 200
            }
        }
    ]
}
