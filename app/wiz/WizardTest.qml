// states: [
//     State {
//         name: "hover"
//         PropertyChanges { target: xx; width: 54 }
//         PropertyChanges { target: xx; height: 54 }
//     }, State {
//         name: "exited"
//         PropertyChanges { target: xx; width: 60 }
//         PropertyChanges { target: xx; height: 60 }
//     }
// ]

// NumberAnimation { id: anim; duration: 200; easing.type: Easing.OutCubic }
// Behavior on width { animation: anim }
// Behavior on height { animation: anim }


import "../mock/Windows.js" as Windows
import "../mock/NetworkType.js" as NetworkType
import "../mock/Settings.js" as Settings
import "../components"
import "../components" as MoneroComponents

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0


Rectangle {
    id: wizardHome
    property string xcolor: "red"
    Layout.fillWidth: true
    color: "transparent"
    property string fontColorDimmed: "#c0c0c0"

    Rectangle {
        Layout.topMargin: 0 * scaleRatio
        Layout.bottomMargin: 0 * scaleRatio
        Layout.preferredHeight: 5
        Layout.fillWidth: true
        color: MoneroComponents.Style.dividerColor
        opacity: MoneroComponents.Style.dividerOpacity
    }

    Rectangle {
        color: parent.xcolor
        anchors.fill: parent
    }
}
