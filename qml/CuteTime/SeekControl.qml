import QtQuick 2.0

Item {
    id: root
    height: seekSlider.height

    property int position: 0
    property int duration: 0
    property bool seekable: false
    property alias pressed : seekSlider.pressed
    property bool enabled

    signal seekValueChanged(int newPosition)

    onPositionChanged: {
        elapsedText.text = formatTime(position);
        seekSlider.value = position;
    }

    onDurationChanged: {
        remainingText.text = formatTime(duration);
    }

    Text {
        id: elapsedText
        anchors.verticalCenter: seekSlider.verticalCenter
        anchors.left: root.left
        text: "00:00"
        font.pixelSize: 20
        color: "#cccccc"
    }

    Slider {
        id: seekSlider
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        anchors.left: elapsedText.right
        anchors.right: remainingText.left
        anchors.verticalCenter: root.verticalCenter
        mutable: root.seekable
        enabled: root.enabled

        minimum: 0.0
        maximum: root.duration !== 0 ? root.duration : 1

        onValueChangedByHandle: {
            seekValueChanged(newValue);
            applicationWindow.resetTimer()
        }
    }

    Text {
        id: remainingText
        anchors.verticalCenter: seekSlider.verticalCenter
        anchors.right: root.right
        text: "00:00"
        font.pixelSize: 20
        color: "#cccccc"
    }

    function formatTime(time) {
        time = time / 1000
        var hours = Math.floor(time / 3600);
        time = time - hours * 3600;
        var minutes = Math.floor(time / 60);
        var seconds = Math.floor(time - minutes * 60);

        if (hours > 0)
            return formatTimeBlock(hours) + ":" + formatTimeBlock(minutes) + ":" + formatTimeBlock(seconds);
        else
            return formatTimeBlock(minutes) + ":" + formatTimeBlock(seconds);

    }

    function formatTimeBlock(time) {
        if (time === 0)
            return "00"
        if (time < 10)
            return "0" + time;
        else
            return time.toString();
    }
}
