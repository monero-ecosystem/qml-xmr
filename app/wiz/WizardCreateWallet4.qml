import "../mock/Windows.js" as Windows
import "../mock/NetworkType.js" as NetworkType
import "../mock/Settings.js" as Settings
import "../js/Wizard.js" as Wizard
import "../components"
import "../components" as MoneroComponents

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0


Rectangle {
    id: wizardCreateWallet4

    color: "transparent"
    property string viewName: "wizardCreateWallet4"
    property string fontColorDimmed: "#c0c0c0"

    ColumnLayout {
        id: root

        // anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 100
        anchors.leftMargin: 140
        anchors.rightMargin: 140

        spacing: 20 * scaleRatio

        ColumnLayout {
            Layout.fillWidth: true
            Layout.maximumWidth: 660
            Layout.alignment: Qt.AlignHCenter
            spacing: 30

            ColumnLayout {
                spacing: 8
                Layout.maximumWidth: 660

                Text {
                    text: "You're all set up!"
                    Layout.fillWidth: true
                    color: MoneroComponents.Style.defaultFontColor
                    font.pixelSize: {
                        if(wizardController.layoutScale === 2 ){
                            return 34 * scaleRatio;
                        } else {
                            return 22 * scaleRatio;
                        }
                    }
                }

                TextArea {
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.dimmedFontColor
                    text: "New wallet details:"

                    font.pixelSize: {
                        if(wizardController.layoutScale === 2 ){
                            return 16 * scaleRatio;
                        } else {
                            return 14 * scaleRatio;
                        }
                    }

                    selectByMouse: false
                    wrapMode: Text.WordWrap
                    textMargin: 0
                    leftPadding: 0
                    topPadding: 0
                    readOnly: true

                    // @TODO: Legacy. Remove after Qt 5.8.
                    // https://stackoverflow.com/questions/41990013
                    MouseArea {
                        anchors.fill: parent
                        enabled: false
                    }
                }

                GridLayout {
                    Layout.topMargin: 20 * scaleRatio
                    columns: 2
                    columnSpacing: 0

                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        font.pixelSize: 16
                        font.bold: true
                        text: qsTr("Wallet name") + translationManager.emptyString
                    }

                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 360
                        font.pixelSize: 14
                        text: walletOptionsName
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }


                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        font.pixelSize: 16
                        font.bold: true
                        text: qsTr("Wallet path") + translationManager.emptyString
                    }

                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 360
                        font.pixelSize: 14
                        text: walletOptionsLocation
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }

                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        font.pixelSize: 16
                        font.bold: true
                        text: qsTr("Language") + translationManager.emptyString
                    }

                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 360
                        font.pixelSize: 14
                        text: walletOptionsLanguage
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }

                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        font.pixelSize: 16
                        font.bold: true
                        text: qsTr("Daemon address") + translationManager.emptyString
                    }

                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 360
                        font.pixelSize: 14
                        text: daemonOptionsAddress
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }


                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        font.pixelSize: 16
                        font.bold: true
                        text: qsTr("Network Type") + translationManager.emptyString
                    }

                    MoneroComponents.TextBlock {
                        Layout.fillWidth: true
                        Layout.maximumWidth: 360
                        font.pixelSize: 14
                        text: daemonOptionsNetType
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }

                    Rectangle {
                        height: 1
                        Layout.topMargin: 2 * scaleRatio
                        Layout.bottomMargin: 2 * scaleRatio
                        Layout.fillWidth: true
                        color: MoneroComponents.Style.dividerColor
                        opacity: MoneroComponents.Style.dividerOpacity
                    }
                }
            }

            GridLayout {
                Layout.topMargin: 20 * scaleRatio
                Layout.fillWidth: true
                Layout.maximumWidth: 660 * scaleRatio
                columns: 2

                MoneroComponents.StandardButton{
                    text: "Previous"

                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth: 120 * scaleRatio

                    onClicked: {
                        wizardStateView.state = "wizardCreateWallet3";
                    }
                }

                MoneroComponents.StandardButton{
                    text: "Use Monero"

                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth: 120 * scaleRatio

                    onClicked: {
                        wizardStateView.state = "";
                    }
                }
            }
        }
    }
}
