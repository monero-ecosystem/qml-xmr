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
    
    color: "transparent"
    property string fontColorDimmed: "#c0c0c0"

    ColumnLayout {
        id: root

        // anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 100
        anchors.leftMargin: 80
        anchors.rightMargin: 80
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 20 * scaleRatio

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 30

            Text {
                text: "Create a new wallet"
                Layout.fillWidth: true
                color: MoneroComponents.Style.defaultFontColor
                font.pixelSize: {
                    if(wizardController.layoutScale === 2 ){
                        return 36 * scaleRatio;
                    } else {
                        return 22 * scaleRatio;
                    }
                }
            }

            MoneroComponents.LineEditMulti {
                id: walletName
                Layout.maximumWidth: {
                    if(wizardController.layoutScale === 2)
                        return parent.width / 2;
                    return parent.width
                }
                spacing: 0
                wrapMode: Text.WrapAnywhere
                addressValidation: false
                labelText: "Wallet name"
                labelFontSize: 14 * scaleRatio
                placeholderText: "Enter a name"
                text: ""
            }

            ColumnLayout {
                spacing: 12
                MoneroComponents.LineEditMulti {
                    id: seed
                    spacing: 0
                    fontSize: 18 * scaleRatio
                    wrapMode: Text.WordWrap
                    addressValidation: false
                    labelText: "Seed"
                    labelFontSize: 14 * scaleRatio
                    copyButton: true
                    placeholderText: "Enter a name"
                    text: "joining hull estate tanks cube vain lamb jerseys kettle usual nerves wobbly opacity faulty succeed meeting stellar threaten gasp dialect ridges deity hairy injury threaten"
                }

                MoneroComponents.WarningBox {
                    // Layout.maximumWidth: parent.width / 1.2
                    text: "This seed is <b style=\"text-decoration: underline;\">very</b> important to write down and keep secret. It is all you need to backup and restore your wallet."
                }
            }
        }
    }
}