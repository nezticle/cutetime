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
    color: "#BB333333"
    height: 78
    property int itemHeight: 25
    property string effectSource: ""
    property bool isMouseAbove: mouseAboveMonitor.containsMouse

    Keys.onEscapePressed: visible = false

    signal clicked
    QtObject {
        id: d
        property Item selectedItem
    }

    ListModel {
        id: sources
        ListElement { name: "No effect"; source: "Effects/EffectPassThrough.qml" }
        ListElement { name: "Billboard"; source: "Effects/EffectBillboard.qml" }
        ListElement { name: "Black & white"; source: "Effects/EffectBlackAndWhite.qml" }
        ListElement { name: "Blur"; source: "Effects/EffectGaussianBlur.qml" }
        ListElement { name: "Edge detection"; source: "Effects/EffectSobelEdgeDetection1.qml" }
        ListElement { name: "Emboss"; source: "Effects/EffectEmboss.qml" }
        ListElement { name: "Glow"; source: "Effects/EffectGlow.qml" }
        ListElement { name: "Isolate"; source: "Effects/EffectIsolate.qml" }
        //ListElement { name: "Magnify"; source: "Effects/EffectMagnify.qml" }
//        ListElement { name: "Page curl"; source: "Effects/EffectPageCurl.qml" }
        ListElement { name: "Pixelate"; source: "Effects/EffectPixelate.qml" }
        ListElement { name: "Posterize"; source: "Effects/EffectPosterize.qml" }
        ListElement { name: "Ripple"; source: "Effects/EffectRipple.qml" }
        ListElement { name: "Sepia"; source: "Effects/EffectSepia.qml" }
        ListElement { name: "Sharpen"; source: "Effects/EffectSharpen.qml" }
        ListElement { name: "Shockwave"; source: "Effects/EffectShockwave.qml" }
//        ListElement { name: "Tilt shift"; source: "Effects/EffectTiltShift.qml" }
        ListElement { name: "Toon"; source: "Effects/EffectToon.qml" }
        ListElement { name: "Warhol"; source: "Effects/EffectWarhol.qml" }
        ListElement { name: "Wobble"; source: "Effects/EffectWobble.qml" }
        ListElement { name: "Vignette"; source: "Effects/EffectVignette.qml" }
    }

    Component {
        id: sourceDelegate
        Item {
            id: sourceDelegateItem
            width: root.width
            height: itemHeight

            Text {
                id: sourceSelectorItem
                anchors.centerIn: parent
                width: 0.9 * parent.width
                height: 0.8 * itemHeight
                text: name
                color: "white"
            }

            states: [
                State {
                    name: "selected"
                    PropertyChanges {
                        target: sourceSelectorItem
                        bgColor: "#ff8888"
                    }
                }
            ]

            transitions: [
                Transition {
                    from: "*"
                    to: "*"
                    ColorAnimation {
                        properties: "color"
                        easing.type: Easing.OutQuart
                        duration: 500
                    }
                }
            ]
        }
    }

    MouseArea {
        id: mouseAboveMonitor
        anchors.fill: parent
        hoverEnabled: true
    }

    ListView {
        id: list
        anchors.fill: parent
        clip: true
        anchors.margins: 14
        model: sources
        focus: root.visible && root.opacity && urlBar.opacity === 0

        currentIndex: 0

        onCurrentIndexChanged : {
            effectSource = model.get(currentIndex).source
            root.clicked()
            applicationWindow.resetTimer()
        }

        delegate: Item {
            height: 40
            width: parent.width
            Rectangle {
                anchors.fill: parent
                border.color: index == list.currentIndex ? "#44ffffff" : "transparent"
                color: index == list.currentIndex ? "#22ffffff" : "transparent"
                radius: 3
                Text { color: "white" ; text: name ; anchors.centerIn: parent; font.pixelSize: 20  }
                MouseArea {
                    anchors.fill: parent
                    onClicked:  list.currentIndex = index
                }
            }
        }
    }
}
