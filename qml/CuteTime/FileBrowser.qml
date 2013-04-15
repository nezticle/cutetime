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
import Qt.labs.folderlistmodel 2.0

Rectangle {
    id: fileBrowser
    color: "transparent"

    property string folder: "file:///sdcard/Movies"

    signal fileSelected(string file)

    function selectFile(file) {
        if (file != "")
            folder = loader.item.folders.folder
        loader.sourceComponent = undefined
        if (file != "")
            fileBrowser.fileSelected("file://" + file)
    }

    Loader {
        id: loader
    }

    function show() {
        loader.sourceComponent = fileBrowserComponent
        loader.item.parent = fileBrowser
        loader.item.anchors.fill = fileBrowser
        loader.item.folder = fileBrowser.folder
    }

    Component {
        id: fileBrowserComponent

        Rectangle {
            id: root
            gradient: Gradient {
                GradientStop { position: 0; color: "#111111" }
                GradientStop { position: 1; color: "#222222"}
            }
            property bool showFocusHighlight: false
            property variant folders: folders1
            property variant view: view1
            property alias folder: folders1.folder
            property color textColor: "white"

            FolderListModel {
                id: folders1
                folder: folder
            }

            FolderListModel {
                id: folders2
                folder: folder
            }

            SystemPalette {
                id: palette
            }

            Component {
                id: folderDelegate

                Rectangle {
                    id: wrapper
                    function launch() {
                        if (folders.isFolder(index))
                            down(filePath);
                        else
                            fileBrowser.selectFile(filePath)
                    }
                    width: root.width
                    height: 50
                    color: "transparent"

                    Rectangle {
                        id: highlight; visible: false
                        anchors.fill: parent
                        color: palette.highlight
                        gradient: Gradient {
                            GradientStop { id: t1; position: 0.0; color: palette.highlight }
                            GradientStop { id: t2; position: 1.0; color: Qt.lighter(palette.highlight) }
                        }
                    }

                    Item {
                        width: 40; height: 40
                        y: 3
                        x: 5
                        Image {
                            source: "images/FileButton.png"
                            width: 34; height: 34
                            anchors.centerIn: parent
                            visible: folders.isFolder(index)
                        }
                    }

                    Text {
                        id: nameText
                        anchors.fill: parent; verticalAlignment: Text.AlignVCenter
                        text: fileName
                        anchors.leftMargin: 54
                        font.pixelSize: 24
                        color: (wrapper.ListView.isCurrentItem && root.showFocusHighlight) ? palette.highlightedText : textColor
                        elide: Text.ElideRight
                    }

                    MouseArea {
                        id: mouseRegion
                        anchors.fill: parent
                        onPressed: {
                            root.showFocusHighlight = false;
                            wrapper.ListView.view.currentIndex = index;
                        }
                        onClicked: { if (folders == wrapper.ListView.view.model) launch() }
                    }

                    states: [
                        State {
                            name: "pressed"
                            when: mouseRegion.pressed
                            PropertyChanges { target: highlight; visible: true }
                            PropertyChanges { target: nameText; color: palette.highlightedText }
                        }
                    ]
                }
            }

            ListView {
                id: view1
                anchors.top: titleBar.bottom
                anchors.topMargin: 15
                anchors.bottom: parent.bottom
                x: 0
                width: parent.width
                model: folders1
                delegate: folderDelegate
                highlight: Rectangle {
                    color: palette.highlight
                    visible: root.showFocusHighlight && view1.count != 0
                    gradient: Gradient {
                        GradientStop { id: t1; position: 0.0; color: palette.highlight }
                        GradientStop { id: t2; position: 1.0; color: Qt.lighter(palette.highlight) }
                    }
                    width: view1.currentItem == null ? 0 : view1.currentItem.width
                }
                highlightMoveVelocity: 1000
                pressDelay: 100
                focus: true
                state: "current"
                states: [
                    State {
                        name: "current"
                        PropertyChanges { target: view1; x: 0 }
                    },
                    State {
                        name: "exitLeft"
                        PropertyChanges { target: view1; x: -root.width }
                    },
                    State {
                        name: "exitRight"
                        PropertyChanges { target: view1; x: root.width }
                    }
                ]
                transitions: [
                    Transition {
                        to: "current"
                        SequentialAnimation {
                            NumberAnimation { properties: "x"; duration: 250 }
                        }
                    },
                    Transition {
                        NumberAnimation { properties: "x"; duration: 250 }
                        NumberAnimation { properties: "x"; duration: 250 }
                    }
                ]
                Keys.onPressed: root.keyPressed(event.key)
            }

            ListView {
                id: view2
                anchors.top: titleBar.bottom
                anchors.topMargin: 15
                anchors.bottom: parent.bottom
                x: parent.width
                width: parent.width
                model: folders2
                delegate: folderDelegate
                highlight: Rectangle {
                    color: palette.highlight
                    visible: root.showFocusHighlight && view2.count != 0
                    gradient: Gradient {
                        GradientStop { id: t1; position: 0.0; color: palette.highlight }
                        GradientStop { id: t2; position: 1.0; color: Qt.lighter(palette.highlight) }
                    }
                    width: view1.currentItem == null ? 0 : view1.currentItem.width
                }
                highlightMoveVelocity: 1000
                pressDelay: 100
                states: [
                    State {
                        name: "current"
                        PropertyChanges { target: view2; x: 0 }
                    },
                    State {
                        name: "exitLeft"
                        PropertyChanges { target: view2; x: -root.width }
                    },
                    State {
                        name: "exitRight"
                        PropertyChanges { target: view2; x: root.width }
                    }
                ]
                transitions: [
                    Transition {
                        to: "current"
                        SequentialAnimation {
                            NumberAnimation { properties: "x"; duration: 250 }
                        }
                    },
                    Transition {
                        NumberAnimation { properties: "x"; duration: 250 }
                    }
                ]
                Keys.onPressed: root.keyPressed(event.key)
            }

            Keys.onPressed: {
                root.keyPressed(event.key);
                if (event.key == Qt.Key_Return || event.key == Qt.Key_Select || event.key == Qt.Key_Right) {
                    view.currentItem.launch();
                    event.accepted = true;
                } else if (event.key == Qt.Key_Left) {
                    up();
                }
            }

            Rectangle {
                width: parent.width;
                height: 70
                color: "#111111"
                y: -7
                id: titleBar

                Rectangle {
                    id: upButton
                    width: 90
                    height: titleBar.height - 7
                    color: "transparent"
                    Image { anchors.centerIn: parent; source: "images/up.png"; width: 32; height: 32 }
                    MouseArea { id: upRegion; anchors.centerIn: parent
                        anchors.fill: parent
                        onClicked: if (folders.parentFolder != "") up()
                    }
                    states: [
                        State {
                            name: "pressed"
                            when: upRegion.pressed
                            PropertyChanges { target: upButton; color: palette.highlight }
                        }
                    ]
                }

//                Rectangle {
//                    color: "gray"
//                    x: 70
//                    width: 1
//                    height: 63
//                }

                Rectangle {
                    id: cancelButton
                    width: 100
                    height: titleBar.height - 7
                    color: "transparent"
                    anchors { left: upButton.right; leftMargin: 1; }

                    Text {
                        anchors { fill: parent; topMargin: 3 }
                        text: "Cancel"
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 22
                    }

                    MouseArea {
                        id: cancelRegion
                        anchors.fill: parent
                        onClicked: fileBrowser.selectFile("")
                    }

                    states: [
                        State {
                            name: "pressed"
                            when: cancelRegion.pressed
                            PropertyChanges { target: cancelButton; color: palette.highlight }
                        }
                    ]
                }

//                Rectangle {
//                    color: "gray"
//                    x: 171
//                    width: 1
//                    height: 63
//                }

                Text {
                    anchors.left: cancelButton.right; anchors.right: parent.right; height: parent.height
                    anchors.leftMargin: 4; anchors.rightMargin: 4
                    text: String(folders.folder).replace("file://", "")
                    color: "white"
                    elide: Text.ElideLeft; horizontalAlignment: Text.AlignRight; verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 28
                }

                Rectangle {
                    width: parent.width
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 3
                    height: 2
                    color: palette.highlight
                }
            }

            function down(path) {
                if (folders == folders1) {
                    view = view2
                    folders = folders2;
                    view1.state = "exitLeft";
                } else {
                    view = view1
                    folders = folders1;
                    view2.state = "exitLeft";
                }
                view.x = root.width;
                view.state = "current";
                view.focus = true;
                folders.folder = "file://" + path;
            }

            function up() {
                var path = folders.parentFolder;
                if (folders == folders1) {
                    view = view2
                    folders = folders2;
                    view1.state = "exitRight";
                } else {
                    view = view1
                    folders = folders1;
                    view2.state = "exitRight";
                }
                view.x = -root.width;
                view.state = "current";
                view.focus = true;
                folders.folder = path;
            }

            function keyPressed(key) {
                switch (key) {
                    case Qt.Key_Up:
                    case Qt.Key_Down:
                    case Qt.Key_Left:
                    case Qt.Key_Right:
                        root.showFocusHighlight = true;
                    break;
                    default:
                        // do nothing
                    break;
                }
            }
        }
    }
}
