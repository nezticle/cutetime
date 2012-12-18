/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtMultimedia 5.0

FocusScope {
    id: applicationWindow
    width: 640
    height: 480
    focus: true

    MouseArea {
        id: mouseActivityMonitor
        anchors.fill: parent

        hoverEnabled: true
        onPositionChanged: {
            controlBar.show();
            controlBarTimer.restart();
        }

        onPressed: {
            hideToolBars();
        }

        onDoubleClicked: {
            viewer.toggleFullscreen();
        }
    }

    signal resetTimer
    onResetTimer: {
        controlBar.show();
        controlBarTimer.restart();
    }

    Component.onCompleted: {
        init();
    }

    Content {
        id: content
        anchors.fill: parent

        onContentSizeChanged: {
            viewer.suggestResize(contentSize);
        }
    }

    Timer {
        id: controlBarTimer
        interval: 1000
        running: false

        onTriggered: {
            hideToolBars();
        }
    }

    ControlBar {
        id: controlBar
        anchors.horizontalCenter: applicationWindow.horizontalCenter
        anchors.bottom: applicationWindow.bottom
        anchors.bottomMargin: 50
        mediaPlayer: content.videoPlayer.mediaPlayer

        onOpenFile: {
            applicationWindow.openVideo();
        }

        onOpenURL: {
            applicationWindow.openURL();
        }

        onOpenFX: {
            applicationWindow.openFX();
        }

        onToggleFullScreen: {
            viewer.toggleFullscreen();
        }
    }

    ParameterPanel {
        id: parameterPanel
        opacity: controlBar.opacity
        visible: effectSelectionPanel.visible && model.count !== 0
        height: 100
        anchors {
            left: controlBar.left
            bottom: controlBar.top
            right: effectSelectionPanel.left
        }
    }

    EffectSelectionPanel {
        id: effectSelectionPanel
        visible: false
        opacity: controlBar.opacity
        anchors {
            bottom: controlBar.top
            right: controlBar.right
        }
        width: 150
        height: 200
        itemHeight: 40
        onEffectSourceChanged: {
            content.effectSource = effectSource
            parameterPanel.model = content.effect.parameters
        }
    }

    UrlBar {
        id: urlBar
        opacity: 0
        visible: opacity != 0
        anchors.fill: parent
        onUrlAccepted: {
            urlBar.opacity = 0;
            if (text != "")
                content.openVideo(text)
        }
    }

    property real volumeBeforeMuted: 1.0
    property bool isFullScreen: false
    Connections {
        target: viewer
        onWindowStateChanged: applicationWindow.isFullScreen = (windowState & Qt.WindowFullScreen)
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_O && event.modifiers & Qt.ControlModifier) {
            openVideo();
            return;
        } else if (event.key === Qt.Key_N && event.modifiers & Qt.ControlModifier) {
            openURL();
            return;
        } else if (event.key === Qt.Key_E && event.modifiers & Qt.ControlModifier) {
            openFX();
            return;
        } else if (event.key === Qt.Key_F && event.modifiers & Qt.ControlModifier) {
            viewer.toggleFullscreen();
            return;
        } else if (event.key === Qt.Key_Up) {
            content.videoPlayer.mediaPlayer.volume = Math.min(1, content.videoPlayer.mediaPlayer.volume + 0.1);
            return;
        } else if (event.key === Qt.Key_Down) {
            if (event.modifiers & Qt.ControlModifier) {
                if (content.videoPlayer.mediaPlayer.volume) {
                    volumeBeforeMuted = content.videoPlayer.mediaPlayer.volume;
                    content.videoPlayer.mediaPlayer.volume = 0
                } else {
                    content.videoPlayer.mediaPlayer.volume = volumeBeforeMuted;
                }
            } else {
                content.videoPlayer.mediaPlayer.volume = Math.max(0, content.videoPlayer.mediaPlayer.volume - 0.1);
            }
            return;
        } else if (applicationWindow.isFullScreen && event.key === Qt.Key_Escape) {
            viewer.toggleFullscreen();
            return;
        }

        // What's next should be handled only if there's a loaded media
        if (content.videoPlayer.mediaPlayer.status !== MediaPlayer.Loaded
                && content.videoPlayer.mediaPlayer.status !== MediaPlayer.Buffered)
            return;

        if (event.key === Qt.Key_Space) {
            if (content.videoPlayer.mediaPlayer.playbackState === MediaPlayer.PlayingState)
                content.videoPlayer.mediaPlayer.pause()
            else if (content.videoPlayer.mediaPlayer.playbackState === MediaPlayer.PausedState
                     || content.videoPlayer.mediaPlayer.playbackState === MediaPlayer.StoppedState)
                content.videoPlayer.mediaPlayer.play()
        } else if (event.key === Qt.Key_Left) {
            content.videoPlayer.mediaPlayer.seek(Math.max(0, content.videoPlayer.mediaPlayer.position - 30000));
            return;
        } else if (event.key === Qt.Key_Right) {
            content.videoPlayer.mediaPlayer.seek(Math.min(content.videoPlayer.mediaPlayer.duration, content.videoPlayer.mediaPlayer.position + 30000));
            return;
        }
    }

    function init() {
        content.init()
        if (fileName != "")
            content.openVideo(fileName)
    }

    function openVideo() {
        //videoFileBrowser.show()
        var videoFile = viewer.openFileDialog();
        if (videoFile != "")
            content.openVideo(videoFile);
    }

    function openCamera() {
        content.openCamera()
    }

    function openURL() {
        urlBar.opacity = urlBar.opacity === 0 ? 1 : 0
    }

    function openFX() {
        effectSelectionPanel.visible = !effectSelectionPanel.visible;
    }

    function close() {
    }

    function hideToolBars() {
        if (!controlBar.isMouseAbove && !parameterPanel.isMouseAbove && !effectSelectionPanel.isMouseAbove && content.videoPlayer.isPlaying)
            controlBar.hide();
    }
}
