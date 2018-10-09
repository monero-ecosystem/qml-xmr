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
    id: wizardCreateWallet1
    
    color: "transparent"
    property string viewName: "wizardCreateWallet1"
    property string fontColorDimmed: "#c0c0c0"

    function verify() {
        // @TODO: check if walletName already exists in walletLocation
        return walletName.text !== '';
    }

    ColumnLayout {
        id: root

        // anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 100
        anchors.leftMargin: 140
        anchors.rightMargin: 140

        spacing: 30 * scaleRatio

        ColumnLayout {
            Layout.fillWidth: true
            Layout.maximumWidth: 660
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            ColumnLayout {
                spacing: 8
                Layout.maximumWidth: 660

                Text {
                    text: "Create a new wallet"
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
                    text: "Creates a new wallet on this computer."

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
            }

            MoneroComponents.LineEditMulti {
                id: walletName
                Layout.maximumWidth: 660
                spacing: 0
                wrapMode: Text.WrapAnywhere
                addressValidation: false
                labelText: "Wallet name"
                labelFontSize: 14 * scaleRatio
                placeholderText: "Enter a name"
                text: walletOptionsName
            }

            ColumnLayout {
                spacing: 0
                Layout.maximumWidth: 660

                MoneroComponents.LineEditMulti {
                    id: seed

                    spacing: 0
                    fontSize: 18 * scaleRatio
                    fontBold: true
                    wrapMode: Text.WordWrap
                    backgroundColor: "#09FFFFFF"
                    addressValidation: false
                    labelText: "Seed"
                    labelFontSize: 14 * scaleRatio
                    copyButton: false
                    readOnly: true
                    borderRadius: 0
                    placeholderText: "Enter a name"
                    leftPadding: 16 * scaleRatio
                    rightPadding: 16 * scaleRatio
                    text: "joining hull estate tanks cube vain lamb jerseys kettle usual nerves wobbly opacity faulty succeed meeting stellar threaten gasp dialect ridges deity hairy injury threaten"
                }

                MoneroComponents.WarningBox {
                    Rectangle {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: 1
                        color: MoneroComponents.Style.inputBorderColorInActive
                    }

                    Rectangle {
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                        height: 1
                        color: MoneroComponents.Style.inputBorderColorInActive
                    }

                    Rectangle {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: 1
                        color: MoneroComponents.Style.inputBorderColorInActive
                    }

                    radius: 0
                    border.color: MoneroComponents.Style.inputBorderColorInActive
                    border.width: 0

                    text: "This seed is <b>very</b> important to write down and keep secret. It is all you need to backup and restore your wallet."
                }
            }

            MoneroComponents.LineEditMulti {
                id: blockchainLocation
                Layout.maximumWidth: 660
                spacing: 0
                wrapMode: Text.WrapAnywhere
                addressValidation: false
                labelText: "Wallet location"
                labelFontSize: 14 * scaleRatio
                placeholderText: "/home/dsc/Monero/wallets"
                placeholderFontSize: 15 * scaleRatio
                text: ""
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
                        wizardStateView.state = "wizardHome";
                    }
                }

                MoneroComponents.StandardButton{
                    text: "Next"

                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth: 120 * scaleRatio

                    enabled: verify()

                    onClicked: {
                        walletOptionsName = walletName.text;
                        wizardStateView.state = "wizardCreateWallet2";
                    }
                }
            }
        }
    }
}
