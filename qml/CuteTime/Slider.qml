import QtQuick 2.0

Item {
    id: slider

    height: handleBack.height
    // value is read/write.
    property real value: 0
    property real maximum: 1
    property real minimum: 0
    property int xMax: width - handle.width
    onXMaxChanged: updatePos()
    onMinimumChanged: updatePos()
    onValueChanged: if (!pressed) updatePos()
    property bool mutable: true
    property alias pressed : backgroundMouse.pressed

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

    Rectangle {
        id: background
        width: slider.width
        anchors.verticalCenter: slider.verticalCenter
        height: 2
        color: "#666666"

        MouseArea {
            id: backgroundMouse
            anchors.fill: parent
            anchors.topMargin: -24
            anchors.bottomMargin: -24
            enabled: slider.mutable
            drag.target: handle
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: slider.xMax
            onPressedChanged: {
                value = Math.max(minimum, Math.min(maximum, (maximum - minimum) * (mouseX - handle.width/2) / slider.xMax + minimum));
                valueChangedByHandle(value);
                updatePos();
            }
            onPositionChanged: {
                value = Math.max(minimum, Math.min(maximum, (maximum - minimum) * (mouseX - handle.width/2) / slider.xMax + minimum));
                valueChangedByHandle(value);
            }
            onWheel: {
                value = Math.max(minimum, Math.min(maximum, value + (wheel.angleDelta.y > 0 ? 1 : -1) * (10 / slider.xMax) * (slider.maximum - slider.minimum)));
                valueChangedByHandle(value);
                updatePos();
            }
        }
    }

    Rectangle {
        id: progress
        height: 5
        anchors.verticalCenter: background.verticalCenter
        anchors.left: background.left
        anchors.right: handle.right
        anchors.rightMargin: handle.width / 2
        visible: slider.enabled
        color: "#98c66c"
    }

    Rectangle {
        id: handleBack
        width: 40
        height: width
        radius: width / 2
        color: "#8898c66c"
        antialiasing: true
        anchors.centerIn: handle
        visible: handle.visible
    }

    Rectangle {
        id: handle
        width: 14
        height: width
        radius: width / 2
        antialiasing: true
        color: "#98c66c"
        anchors.verticalCenter: background.verticalCenter
        visible: slider.enabled
    }
}

