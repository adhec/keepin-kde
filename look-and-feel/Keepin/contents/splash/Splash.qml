/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    color: "#222325"
    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } 
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }


        Image {
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 20
            opacity: 0.0
            anchors.centerIn: parent
            source: "images/start.svgz"
            sourceSize.width: size
            sourceSize.height: size
        }
        
        Text {
            id: date
            text:Qt.formatDateTime(new Date(),"dddd, hh:mm")
            font.pointSize: 42
            color: "#c7beb7"
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 2.7
        }

        Image {
            id: busyIndicator1
            //in the middle of the remaining space
            //y: (parent.height - height) / 1.7
            y: root.height - (root.height - logo.y) / 1.9 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busywidget3.svg"
            opacity: 0.9
            sourceSize.height: units.gridUnit * 2.2
            sourceSize.width: units.gridUnit * 2.2
            RotationAnimator on rotation {
                id: rotationAnimator1
                from: 360
                to: 0
                duration: 1100
                loops: Animation.Infinite
            }
        }
        
        Image {
            id: busyIndicator2
            //in the middle of the remaining space
            //y: (parent.height - height) / 1.7
            y: root.height - (root.height - logo.y) / 1.9 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busywidget4.svg"
            opacity: 0.9
            sourceSize.height: units.gridUnit * 2.6
            sourceSize.width: units.gridUnit * 2.6
            RotationAnimator on rotation {
                id: rotationAnimator2
                from: 0
                to: 360
                duration: 1100
                loops: Animation.Infinite
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }
}
