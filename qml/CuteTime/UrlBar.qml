import QtQuick 2.0

Item {
    id: root
    height: 50
    signal urlAccepted(string text);

    Rectangle {
        id: urlBar
        anchors.fill: parent
        color: "white"
        TextInput {
            id: urlInput
            width: urlBar.width
            anchors.verticalCenter: urlBar.verticalCenter
            font.pointSize: 16
            anchors.margins: 5
            color: "black"

            onAccepted: {
                root.urlAccepted(urlInput.text);
            }
        }
    }
}
