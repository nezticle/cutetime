
import QtQuick 2.0

Item {
    id: slider;
    height: background.height
    // value is read/write.
    property real value: 1
    onValueChanged: updatePos();
    property real maximum: 1
    property real minimum: 1
    property int xMax: width - handle.width - 4
    onXMaxChanged: updatePos();
    onMinimumChanged: updatePos();

    function updatePos() {
        if (maximum > minimum) {
            var pos = 2 + (value - minimum) * slider.xMax / (maximum - minimum);
            pos = Math.min(pos, width - handle.width - 2);
            pos = Math.max(pos, 2);
            handle.x = pos;
        } else {
            handle.x = 2;
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
        id: handle
        source: "images/SliderHandle.png"
        border.left: 7
        border.right: 7
        anchors.verticalCenter: background.verticalCenter
        MouseArea {
            id: mouse
            anchors.fill: parent;
            drag.target: parent
            drag.axis: Drag.XAxis;
            drag.minimumX: 2;
            drag.maximumX: slider.xMax+2
            onPositionChanged: {
                value = (maximum - minimum) * (handle.x-2) / slider.xMax + minimum;
            }
        }
    }
}