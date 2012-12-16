
import QtQuick 2.0
import QtMultimedia 5.0

Image {
    id: controlBar
    source: "images/ControlBar.png"

    property QtObject mediaPlayer: null;
    property bool isMouseAbove: false;

    signal openFile();
    signal openCamera();
    signal openURL();
    signal openFX();
    signal toggleFullScreen();

    state: "VISIBLE"

    MouseArea {
        anchors.fill: controlBar
        hoverEnabled: true

        onEntered: controlBar.isMouseAbove = true;
        onExited: controlBar.isMouseAbove = false;
    }

    VolumeControl {
        id: volumeControl
        anchors.verticalCenter: playbackControl.verticalCenter
        anchors.left: controlBar.left
        anchors.leftMargin: 25

        onVolumeChanged: {
        }
    }

    //Playback Controls
    PlaybackControl {
        id: playbackControl
        anchors.horizontalCenter: controlBar.horizontalCenter
        anchors.top: controlBar.top
        anchors.topMargin: 10

        onPlaybackRateChanged: {
            //Try to update the playback rate on content item
            console.debug("rate = " + playbackControl.playbackRate);

            if (mediaPlayer !== null)
                if (playbackRate === 1.0)
                    mediaPlayer.play();
        }


    }

    //Toolbar Controls
    Row {
        id: toolbarMenuButtons
        anchors.left: playbackControl.right
        anchors.leftMargin: 30
        anchors.verticalCenter: playbackControl.verticalCenter
        spacing: 4;

        ImageButton {
            id: fxButton
            imageSource: "images/FXButton.png"
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

    ImageButton {
        id: fullscreenButton
        imageSource: "images/FullscreenButton.png"
        onClicked: {
            //Toggle fullscreen
            toggleFullScreen();
        }
        anchors.right: controlBar.right
        anchors.top: controlBar.top
        anchors.rightMargin: 15
        anchors.topMargin: 15

    }

    //Seek controls
    SeekControl {
        id: seekControl
        anchors.top: playbackControl.bottom
        anchors.topMargin: 13
        anchors.right: controlBar.right
        anchors.left: controlBar.left
        anchors.rightMargin: 15
        anchors.leftMargin: 15

        position: mediaPlayer.position;
        duration: mediaPlayer.duration;
        seekable: mediaPlayer.seekable;
    }

    function hide() {
        if(mediaPlayer.playbackRate !== 0 && !isMouseAbove)
            controlBar.state = "HIDDEN";
    }

    function show() {
        controlBar.state = "VISIBLE";
    }

    Connections {
        target: mediaPlayer
        onStatusChanged: {
            if ((mediaPlayer.status == MediaPlayer.Loaded) || (mediaPlayer.status == MediaPlayer.Buffered))
                playbackControl.playbackEnabled = true;
            else
                playbackControl.playbackEnabled = false;
        }
    }

    Binding {
        target: mediaPlayer; property: 'volume'
        value: volumeControl.volume; when: mediaPlayer !== null
    }

    Binding {
        target: mediaPlayer; property: 'playbackRate'
        value: playbackControl.playbackRate; when: mediaPlayer !== null
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
