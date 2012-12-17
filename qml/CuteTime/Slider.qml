import QtQuick 2.0

Item {
    id: slider

    height: background.height
    // value is read/write.
    property real value: 1
    onValueChanged: updatePos()
    property real maximum: 1
    property real minimum: 0
    property int xMax: width - handle.width
    onXMaxChanged: updatePos()
    onMinimumChanged: updatePos()
    property bool mutable: true

    signal valueChangedByHandle(int newValue)

    function updatePos() {
        if (maximum > minimum) {
            var pos = 0 + (value - minimum) * slider.xMax / (maximum - minimum);
            pos = Math.min(pos, width - handle.width - 0);
            pos = Math.max(pos, 0);
            handle.x = pos;
        } else {
            handle.x = 0;
        }
    }

    BorderImage {
        id: background
        source: "images/SliderBackground.png"
        width: slider.width
        border.left: 6
        border.right: 6

        MouseArea {
            id: backgroundMouse
            anchors.fill: parent
            enabled: slider.mutable
            drag.target: handle
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: slider.xMax
            onClicked: {
                value = (maximum - minimum) * (mouseX - handle.width/2) / slider.xMax + minimum;
                valueChangedByHandle(value);
            }
            onPositionChanged: {
                value = (maximum - minimum) * mouseX / slider.xMax + minimum;
                valueChangedByHandle(value);
            }
        }
    }

    BorderImage {
        id: progress
        source: "images/SliderProgress.png"
        anchors.left: background.left
        anchors.right: handle.right
        anchors.rightMargin: 2
        border.left: 7
        border.right: 7
        visible: slider.enabled
    }

    BorderImage {
        id: handle
        source: "images/SliderHandle.png"
        border.left: 7
        border.right: 7
        anchors.verticalCenter: background.verticalCenter
        visible: slider.enabled
        opacity: slider.mutable ? mouse.containsMouse ? 1 : 0.8 : 0.5
        Behavior on x { id: smoothing ; enabled: false; NumberAnimation{duration: 180} }
        Component.onCompleted: smoothing.enabled = true // Ensure that values are initialized

        MouseArea {
            id: mouse
            hoverEnabled: true
            enabled: slider.mutable
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: slider.xMax
            onPositionChanged: {
                value = (maximum - minimum) * (handle.x) / slider.xMax + minimum;
                valueChangedByHandle(value);
            }
        }
    }
}

