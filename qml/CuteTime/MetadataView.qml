import QtQuick 2.0

Rectangle {
    id: root

    property variant mediaPlayer: null

    anchors.fill: parent
    color: "#AA000000"
    Behavior on opacity { NumberAnimation { } }
    opacity: 0

    Rectangle {
        height: column.height + 30
        width: 500
        color: "#BB222222"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -50


        Column {
            id: column
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 15
            spacing: 12

            Text {
                text: "Media Type: " + (mediaPlayer ? mediaPlayer.metaData.mediaType : "")
                visible: mediaPlayer && mediaPlayer.metaData.mediaType !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Title: " + (mediaPlayer ? mediaPlayer.metaData.title : "")
                visible: mediaPlayer && mediaPlayer.metaData.title !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Artist: " + (mediaPlayer ? mediaPlayer.metaData.leadPerformer : "")
                visible: mediaPlayer && mediaPlayer.metaData.leadPerformer !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Artist: " + (mediaPlayer ? mediaPlayer.metaData.contributingArtist : "")
                visible: mediaPlayer && mediaPlayer.metaData.contributingArtist !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Album: " + (mediaPlayer ? mediaPlayer.metaData.albumTitle : "")
                visible: mediaPlayer && mediaPlayer.metaData.albumTitle !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Album Artist: " + (mediaPlayer ? mediaPlayer.metaData.albumArtist : "")
                visible: mediaPlayer && mediaPlayer.metaData.albumArtist !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Author: " + (mediaPlayer ? mediaPlayer.metaData.author : "")
                visible: mediaPlayer && mediaPlayer.metaData.author !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Composer: " + (mediaPlayer ? mediaPlayer.metaData.composer : "")
                visible: mediaPlayer && mediaPlayer.metaData.composer !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Writer: " + (mediaPlayer ? mediaPlayer.metaData.writer : "")
                visible: mediaPlayer && mediaPlayer.metaData.writer !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Genre: " + (mediaPlayer ? mediaPlayer.metaData.genre : "")
                visible: mediaPlayer && mediaPlayer.metaData.genre !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Track Number: " + (mediaPlayer ? mediaPlayer.metaData.trackNumber : "")
                visible: mediaPlayer && mediaPlayer.metaData.trackNumber !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Year: " + (mediaPlayer ? mediaPlayer.metaData.year : "")
                visible: mediaPlayer && mediaPlayer.metaData.year !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Duration: " + (mediaPlayer ? Qt.formatTime(new Date(mediaPlayer.metaData.duration), mediaPlayer.metaData.duration >= 3600000 ? "H:mm:ss" : "m:ss") : "")
                visible: mediaPlayer && mediaPlayer.metaData.duration !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Resolution: " + (mediaPlayer && mediaPlayer.metaData.resolution !== undefined ? (mediaPlayer.metaData.resolution.width + "x" + mediaPlayer.metaData.resolution.height) : "")
                visible: mediaPlayer && mediaPlayer.metaData.resolution !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Audio Bitrate: " + (mediaPlayer ? Math.round(mediaPlayer.metaData.audioBitRate / 1000) + " kbps"  : "")
                visible: mediaPlayer && mediaPlayer.metaData.audioBitRate !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Video Bitrate: " + (mediaPlayer ? Math.round(mediaPlayer.metaData.videoBitRate / 1000) + " kbps" : "")
                visible: mediaPlayer && mediaPlayer.metaData.videoBitRate !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
            Text {
                text: "Date: " + (mediaPlayer ? Qt.formatDate(mediaPlayer.metaData.date) : "")
                visible: mediaPlayer && mediaPlayer.metaData.date !== undefined
                color: "white"
                font.pixelSize: 24
                width: parent.width
                wrapMode: Text.WordWrap
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.opacity = 0
        enabled: root.opacity !== 0
    }
}
