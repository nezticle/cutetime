import QtQuick 2.0

Item {
    id: slider;
    height: background.height
    // value is read/write.
    property real value: 1
    onValueChanged: updatePos();
    property real maximum: 1
    property real minimum: 1
    property int xMax: width - handle.width
    onXMaxChanged: updatePos();
    onMinimumChanged: updatePos();
    property bool mutable: false

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
        border.left: 6;
        border.right: 6;
    }

    BorderImage {
        id: progress
        source: "images/SliderProgress.png"
        anchors.left: background.left
        anchors.right: handle.right
        anchors.rightMargin: 2
        border.left: 7
        border.right: 7
    }

    BorderImage {
        id: handle
        source: "images/SliderHandle.png"
        border.left: 7
        border.right: 7
        anchors.verticalCenter: background.verticalCenter
        MouseArea {
            id: mouse
            enabled: slider.mutable
            anchors.fill: parent;
            drag.target: parent
            drag.axis: Drag.XAxis;
            drag.minimumX: 0
            drag.maximumX: slider.xMax
            onPositionChanged: {
                value = (maximum - minimum) * (handle.x) / slider.xMax + minimum;
            }
        }
    }
}

