
import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property alias enabled: mouseArea.enabled
    property alias imageSource: image.source

    signal clicked
    state: "NORMAL"

    width: image.width
    height: 24

    Image {
        id: image
        anchors.verticalCenter: parent.verticalCenter
        visible: true
    }

//    Glow {
//        id: glowEffect
//        cached: false
//        visible: false
//        anchors.fill: root
//        radius: 4
//        samples: 24
//        spread: 0
//        fast: true
//        color: "aqua"
//        source: image
//    }

    ColorOverlay {
        id: glowEffect
        anchors.fill: image
        source: image
        color: "aqua"
    }


    MouseArea {
        id: mouseArea
        anchors.fill: root
        onPressed: {
            root.state = "HELD"
        }

        onReleased: {
            root.state = "NORMAL"
        }

        onClicked: {
            root.clicked();
        }
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges {
                target: glowEffect
                visible: false
            }
            PropertyChanges {
                target: image;
                visible: true;
            }
        },
        State {
            name: "HELD"
            PropertyChanges {
                target: image
                visible: false
            }
            PropertyChanges {
                target: glowEffect
                visible: true
            }
        }
    ]

}
