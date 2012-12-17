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

VideoOutput {
    id: videoOutput
    source: mediaPlayer
    fillMode: VideoOutput.PreserveAspectFit
    property alias mediaSource: mediaPlayer.source
    property alias mediaPlayer: mediaPlayer
    property bool isPlaying: false

    MediaPlayer {
        id: mediaPlayer
        autoLoad: true
        autoPlay: true

        onPlaybackRateChanged: {
            //console.debug("playbackRate: " + playbackRate);
        }

        onPlaybackStateChanged: {
            //console.debug("playbackState = " + mediaPlayer.playbackState);
            if (playbackState === MediaPlayer.PlayingState)
                videoOutput.isPlaying = true;
            else
                videoOutput.isPlaying = false;
        }

        onAvailabilityChanged: {
            //console.debug("availability = " + mediaPlayer.availability);
        }

        onErrorChanged: {
            //console.debug("error = " + mediaPlayer.error);
        }

        onStatusChanged: {
            console.debug("status = " + mediaPlayer.status);
            if ((mediaPlayer.status == MediaPlayer.Loaded) || (mediaPlayer.status == MediaPlayer.Buffered)) {
                //now that media is loaded, we should know its size, and should request a resize
                //if we are not fullscreen, then the window should resize to the native size of the video
                //TODO: automatically resize video window to native move size
            }
        }

        onBufferProgressChanged: {
            //console.debug("buffer progress = " + mediaPlayer.bufferProgress);
        }
    }
    function play() { mediaPlayer.play() }
    function stop() { mediaPlayer.stop() }
}
