import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0

import "components" as MoneroComponents

ColumnLayout {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.margins: (isMobile)? 17 : 20
    spacing: 32

    MoneroComponents.LineEdit {
        Layout.fillWidth: true
        labelText: "This is an example label"
        placeholderText: "placeholder text example"
        labelFontSize: 15 * scaleRatio
    }

    MoneroComponents.StandardButton{
        text: "Submit"
        small: true
    }
}