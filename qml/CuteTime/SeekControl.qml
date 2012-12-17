// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

Item {
    id: root

    property int position: 0;
    property int duration: 0;
    property bool seekable: false;

    signal seekValueChanged(int newPosition);

    onPositionChanged: {
        elapsedText.text = formatTime(position);
        seekSlider.value = position;
    }

    onDurationChanged: {
        remainingText.text = formatTime(duration);
    }

    Text {
        id: elapsedText
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left
        text: "00:00:00"
        color: "white"
    }

    Slider {
        id: seekSlider
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.left: elapsedText.right
        anchors.right: remainingText.left
        anchors.verticalCenter: root.verticalCenter
        mutable: root.seekable

        minimum: 0.0
        maximum: root.duration !== 0 ? root.duration : 1;

        onValueChangedByHandle: {
            seekValueChanged(newValue);
        }
    }

    Text {
        id: remainingText
        anchors.verticalCenter: root.verticalCenter
        anchors.right: root.right
        text: "00:00:00"
        color: "white"
    }

    function formatTime(time) {
        time = time / 1000
        var hours = Math.floor(time / 3600);
        time = time - hours * 3600;
        var minutes = Math.floor(time / 60);
        var seconds = Math.floor(time - minutes * 60);

        return formatTimeBlock(hours) + ":" + formatTimeBlock(minutes) + ":" + formatTimeBlock(seconds);

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
