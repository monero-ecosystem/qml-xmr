import "../mock/Windows.js" as Windows
import "../mock/NetworkType.js" as NetworkType
import "../mock/Settings.js" as Settings
import "../components"
import "../components" as MoneroComponents

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0


Rectangle {
    id: root
    
    color: "transparent"
    property string viewName: "wizardCreateWallet2"
    property string fontColorDimmed: "#c0c0c0"
    property int passwordFill: 20
    property string passwordStrengthText: qsTr("Strength: ") + translationManager.emptyString

    function verify(){
        return passwordInput.text === passwordInputConfirm.text && passwordInput.text !== '';
    }

    function calcPasswordStrength(inp){
        progressText.text = passwordStrengthText + qsTr('test') + translationManager.emptyString;
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 100
        anchors.leftMargin: 140
        anchors.rightMargin: 140

        ColumnLayout {
            Layout.fillWidth: true
            Layout.maximumWidth: 660
            Layout.alignment: Qt.AlignHCenter
            spacing: 20 * scaleRatio

            ColumnLayout {
                spacing: 8
                Layout.maximumWidth: 660

                Text {
                    text: "Give your wallet a password"
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
                    text: "Note: this password cannot be recovered. If you forget it then the wallet will have to be restored from its 25 word mnemonic seed."

                    font.pixelSize: {
                        if(wizardController.layoutScale === 2){
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

            MoneroComponents.WarningBox {
                text: "<b>Enter a strong password</b> (Using letters, numbers, and/or symbols)."
            }

            ColumnLayout {
                spacing: 0
                Layout.fillWidth: true

                TextInput {
                    id: progressText
                    anchors.top: parent.top
                    anchors.topMargin: 6
                    font.family: MoneroComponents.Style.fontMedium.name
                    font.pixelSize: 14 * scaleRatio
                    font.bold: false
                    color: "white"
                    text: root.passwordStrengthText + '-'
                    height: 18 * scaleRatio
                    passwordCharacter: "*"
                }

                TextInput {
                    id: progressTextValue
                    font.family: MoneroComponents.Style.fontMedium.name
                    font.pixelSize: 13 * scaleRatio
                    font.bold: true
                    color: "white"
                    height:18 * scaleRatio
                    passwordCharacter: "*"
                }

                Rectangle {
                    id: bar
                    Layout.fillWidth: true
                    Layout.preferredHeight: 8

                    radius: 8 * scaleRatio
                    color: "#333333" // progressbar bg

                    Rectangle {
                        id: fillRect
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        height: bar.height
                        property int maxWidth: bar.width * scaleRatio
                        width: (maxWidth * root.passwordFill) / 100
                        radius: 8
                        // could change color based on progressbar status; if(item.fillLevel < 99 )
                        color: "#FA6800"
                    }

                    Rectangle {
                        color:"#333"
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.leftMargin: 8 * scaleRatio
                    }
                }

            }

            ColumnLayout {
                spacing: 4
                Layout.fillWidth: true

                Label {
                    text: qsTr("Password")
                    Layout.fillWidth: true

                    font.pixelSize: 14 * scaleRatio
                    font.family: MoneroComponents.Style.fontLight.name

                    color: MoneroComponents.Style.defaultFontColor
                }

                TextField {
                    id : passwordInput

                    Layout.topMargin: 6
                    Layout.fillWidth: true

                    bottomPadding: 10
                    leftPadding: 10
                    topPadding: 10

                    horizontalAlignment: TextInput.AlignLeft
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    KeyNavigation.tab: passwordInputConfirm

                    font.family: MoneroComponents.Style.fontLight.name
                    font.pixelSize: 15 * scaleRatio
                    color: MoneroComponents.Style.defaultFontColor
                    selectionColor: MoneroComponents.Style.dimmedFontColor
                    selectedTextColor: MoneroComponents.Style.defaultFontColor

                    text: walletOptionsPassword

                    background: Rectangle {
                        radius: 4
                        border.color: Qt.rgba(255, 255, 255, 0.35)
                        border.width: 1
                        color: "transparent"

                        Image {
                            width: 12
                            height: 16
                            source: "../images/lockIcon.png"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                        }
                    }
                }
            }

            ColumnLayout {
                spacing: 4
                Layout.fillWidth: true

                Label {
                    text: qsTr("Password (confirm)")
                    Layout.fillWidth: true

                    font.pixelSize: 14 * scaleRatio
                    font.family: MoneroComponents.Style.fontLight.name

                    color: MoneroComponents.Style.defaultFontColor
                }

                TextField {
                    id : passwordInputConfirm
                    
                    Layout.topMargin: 6
                    Layout.fillWidth: true

                    bottomPadding: 10
                    leftPadding: 10
                    topPadding: 10

                    horizontalAlignment: TextInput.AlignLeft
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    KeyNavigation.tab: passwordInputConfirm

                    font.family: MoneroComponents.Style.fontLight.name
                    font.pixelSize: 15 * scaleRatio
                    color: MoneroComponents.Style.defaultFontColor
                    selectionColor: MoneroComponents.Style.dimmedFontColor
                    selectedTextColor: MoneroComponents.Style.defaultFontColor

                    text: walletOptionsPassword

                    background: Rectangle {
                        radius: 4
                        border.color: Qt.rgba(255, 255, 255, 0.35)
                        border.width: 1
                        color: "transparent"

                        Image {
                            width: 12
                            height: 16
                            source: "../images/lockIcon.png"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 20
                        }
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
                        wizardStateView.state = "wizardCreateWallet1";
                    }
                }

                MoneroComponents.StandardButton{
                    text: "Next"

                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth: 120 * scaleRatio

                    enabled: verify()

                    onClicked: {
                        wizardStateView.state = "wizardCreateWallet3";
                    }
                }
            }
        }
    }
}