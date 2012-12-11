
import QtQuick 2.0

Image {
    id: controlBar
    width: 442
    height: 69
    source: "images/toolbar.png"
    opacity: 0.95

    property QtObject mediaPlayer: null;

    signal openFile();
    signal openCamera();
    signal openURL();
    signal openFX();
    signal toggleFullScreen();

    state: "HIDDEN"

    VolumeControl {
        id: volumeControl
        anchors.verticalCenter: playbackControl.verticalCenter

        onVolumeChanged: {
            //Try to update volume on content item
            console.debug("volume = " + volumeControl.volume);
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
        anchors.right: controlBar.right
        anchors.top: controlBar.top
        anchors.topMargin: 10;
        anchors.rightMargin: 10;

        spacing: 0;


        ImageButton {
            id: fxButton
            imageSource: "images/fxbutton.png"
            width: 30
            height: 30
            onClicked: {
                openFX();
            }
        }
//        ImageButton {
//            id: cameraButton
//            imageSource: "images/camerabutton.png"
//            width: 30
//            height: 30
//            onClicked: {
//                openCamera();
//            }
//        }
        ImageButton {
            id: fileButton
            imageSource: "images/filebutton.png"
            width: 30
            height: 30
            onClicked: {
                openFile();
            }
        }
        ImageButton {
            id: urlButton
            imageSource: "images/urlbutton.png"
            width: 30
            height: 30
            onClicked: {
                openURL();
            }
        }
    }

    //Seek controls


    //Fullscreen button
    ImageButton {
        id: fullscreenButton
        imageSource: "images/fullscreenbutton.png"
        width: 21
        height: 22
        anchors.margins: 7
        anchors.bottom: controlBar.bottom
        anchors.right: controlBar.right
        onClicked: {
            //Toggle fullscreen
            toggleFullScreen();
        }
    }

    function hide() {
        controlBar.state = "HIDDEN";
    }

    function show() {
        controlBar.state = "VISIBLE";
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
