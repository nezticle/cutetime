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

Rectangle {
    id: root
    width: 640
    height: 480
    color: "black"
    property string fileName
    property bool perfMonitorsLogging: false
    property bool perfMonitorsVisible: false

    QtObject {
        id: d
        property real gripSize: 20
    }

    Content {
        id: content
        anchors.fill: root
    }

    MouseArea {
        id: mouseActivityMonitor
        anchors.fill: root

        hoverEnabled: true
        onPositionChanged: {
            controlBar.show();
            controlBarTimer.restart();
        }
        onExited: {
            controlBar.hide()
            controlBarTimer.stop();
        }
    }

    Timer {
        id: controlBarTimer
        interval: 5000;
        running: false;

        onTriggered: {
            controlBar.hide();
        }
    }

    ControlBar {
        id: controlBar
        anchors.horizontalCenter: root.horizontalCenter
        anchors.bottom: root.bottom
        anchors.bottomMargin: 50
        mediaPlayer: content.videoPlayer

        onOpenFile: {
            root.openVideo();
        }

        onOpenCamera: {
            root.openCamera();
        }

        onOpenURL: {
            root.openURL();
        }

        onOpenFX: {
            root.openFX();
        }

        onToggleFullScreen: {
            viewer.showFullScreen();
        }
    }

    Rectangle {
        id: urlBar
        color: "white"
        visible: false
        anchors.top: root.top
        anchors.horizontalCenter: root.horizontalCenter
        width: root.width
        height: 50;

        TextInput {
            id: urlInput
            anchors.fill: urlBar
            anchors.margins: 5
            color: "black"

            onAccepted: {
                urlBar.visible = false;
                if (urlInput.text != "")
                    content.openVideo(urlInput.text)
            }
        }
    }


    //    ParameterPanel {
    //        id: parameterPanel
    //        anchors {
    //            left: parent.left
    //            bottom: parent.bottom
    //            right: effectSelectionPanel.left
    //            margins: 20
    //        }
    //        gripSize: d.gripSize
    //    }

    //    EffectSelectionPanel {
    //        id: effectSelectionPanel
    //        anchors {
    //            top: parent.top
    //            bottom: fileOpen.top
    //            right: parent.right
    //            margins: 5
    //        }
    //        width: 300
    //        itemHeight: 40
    //        onEffectSourceChanged: {
    //            content.effectSource = effectSource
    //            parameterPanel.model = content.effect.parameters
    //        }
    //    }

    FileBrowser {
        id: videoFileBrowser
        anchors.fill: root
        Component.onCompleted: fileSelected.connect(content.openVideo)
    }

    function init() {
        console.log("[qmlvideofx] main.init")
        videoFileBrowser.folder = videoPath
        content.init()
        if (fileName != "")
            content.openVideo(fileName)
    }

    function openVideo() {
        console.debug("opening video dialog");
        videoFileBrowser.show()
    }

    function openCamera() {
        console.debug("opening camera");
        content.openCamera()
    }

    function openURL() {
        console.debug("opening URL dialog");
        urlBar.visible = true;
    }

    function openFX() {
        console.debug("opening FX dialog");
    }

    function close() {
        content.openImage("images/qt-logo.png")
    }
}
