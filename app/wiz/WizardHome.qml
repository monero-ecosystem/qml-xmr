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
import "../components"
import "../components" as MoneroComponents

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0


Rectangle {
    id: wizardHome
    Layout.fillWidth: true
    color: "transparent"

    // Rectangle {
    //     color: "#242424"
    //     anchors.fill: parent
    // }

    // Image {
    //     opacity: 1.0
    //     anchors.fill: parent
    //     source: "../images/middlePanelBg.jpg"
    // }

    Rectangle {
        Layout.topMargin: 0 * scaleRatio
        Layout.bottomMargin: 0 * scaleRatio
        Layout.preferredHeight: 5
        Layout.fillWidth: true
        color: MoneroComponents.Style.dividerColor
        opacity: MoneroComponents.Style.dividerOpacity
    }

    ColumnLayout {
        id: root
        anchors.margins: (isMobile)? 17 : 20
        anchors.topMargin: 120

        Layout.fillWidth: true
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.leftMargin: 100
        anchors.rightMargin: 100

        spacing: 0 * scaleRatio

        Text {
            text: "How do you want to start?"
            color: "white"
            font.pixelSize: (isMobile)? 16 * scaleRatio : 36 * scaleRatio
            Layout.fillWidth: true
        }

        GridLayout {
            columns: (isMobile)? 1 : 3
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true
            columnSpacing: 92 * scaleRatio

            ColumnLayout {
                spacing: 0
                Layout.fillWidth: true

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    
                    source: "../img/wizardWallet.png"
                }

                Text {
                    Layout.topMargin: 70
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Create a new wallet"
                    font.pixelSize: 15 * scaleRatio
                    color: "white"
                }

                Text {
                    Layout.topMargin: 8 * scaleRatio
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""
                    font.pixelSize: 14 * scaleRatio
                }


                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log('x1');
                    }
                }
            }

            ColumnLayout {
                spacing: 0
                Layout.fillWidth: true

                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    
                    source: "../img/local@3x.png"
                }

                Text {
                    Layout.topMargin: 70
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Restore wallet"
                    font.pixelSize: 15 * scaleRatio
                    color: "white"
                }

                Text {
                    Layout.topMargin: 8 * scaleRatio
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "From keys or mnemonic seed"
                    color: "#c0c0c0"
                    font.pixelSize: 14 * scaleRatio
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log('x2');
                    }
                }
            }

            ColumnLayout {
                spacing: 0
                Layout.fillWidth: true

                Item {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50

                    Image {
                        id: xx3
                        width: 41
                        height: 50
                        source: "../img/remote@3x.png"
                    }
                }

                Text {
                    Layout.topMargin: 70
                    text: "Open an existing wallet"
                    font.pixelSize: 15 * scaleRatio
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    Layout.topMargin: 8 * scaleRatio
                    text: "From a local wallet file"
                    color: "#c0c0c0"
                    font.pixelSize: 14 * scaleRatio
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log('x3');
                    }
                }
            }
        }

        Rectangle {
            Layout.topMargin: 30 * scaleRatio
            Layout.bottomMargin: 30 * scaleRatio
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            color: MoneroComponents.Style.dividerColor
            opacity: MoneroComponents.Style.dividerOpacity
        }

        MoneroComponents.CheckBox2 {
            id: showAdvancedCheckbox
            Layout.fillWidth: true
            fontSize: 15 * scaleRatio
            checked: false
            onClicked: {
                console.log('Advanced options')
            }
            text: qsTr("Advanced options") + translationManager.emptyString
        }

        RowLayout {
            visible: showAdvancedCheckbox.checked
            Layout.fillWidth: true

            ColumnLayout {
                Layout.leftMargin: wizardLeftMargin
                Layout.rightMargin: wizardRightMargin
                Layout.topMargin: 30 * scaleRatio
                Layout.alignment: Qt.AlignCenter
                Layout.fillWidth: true
                spacing: 38 * scaleRatio


                Rectangle {
                    width: 100 * scaleRatio
                    MoneroComponents.RadioButton {
                        visible: showAdvancedCheckbox.checked
                        enabled: !this.checked
                        id: mainNet
                        text: qsTr("Mainnet") + translationManager.emptyString
                        checkedColor: Qt.rgba(0, 0, 0, 0.75)
                        borderColor: Qt.rgba(0, 0, 0, 0.45)
                        fontColor: "#4A4646"
                        fontSize: 16 * scaleRatio
                        checked: appWindow.persistentSettings.nettype == NetworkType.MAINNET;
                        onClicked: {
                            persistentSettings.nettype = NetworkType.MAINNET
                            testNet.checked = false;
                            stageNet.checked = false;
                            console.log("Network type set to MainNet")
                        }
                    }
                }

                Rectangle {
                    width: 100 * scaleRatio
                    MoneroComponents.RadioButton {
                        visible: showAdvancedCheckbox.checked
                        enabled: !this.checked
                        id: testNet
                        text: qsTr("Testnet") + translationManager.emptyString
                        checkedColor: Qt.rgba(0, 0, 0, 0.75)
                        borderColor: Qt.rgba(0, 0, 0, 0.45)
                        fontColor: "#4A4646"
                        fontSize: 16 * scaleRatio
                        checked: appWindow.persistentSettings.nettype == NetworkType.TESTNET;
                        onClicked: {
                            persistentSettings.nettype = testNet.checked ? NetworkType.TESTNET : NetworkType.MAINNET
                            mainNet.checked = false;
                            stageNet.checked = false;
                            console.log("Network type set to ", persistentSettings.nettype == NetworkType.TESTNET ? "Testnet" : "Mainnet")
                        }
                    }
                }

                Rectangle {
                    width: 100 * scaleRatio
                    MoneroComponents.RadioButton {
                        visible: showAdvancedCheckbox.checked
                        enabled: !this.checked
                        id: stageNet
                        text: qsTr("Stagenet") + translationManager.emptyString
                        checkedColor: Qt.rgba(0, 0, 0, 0.75)
                        borderColor: Qt.rgba(0, 0, 0, 0.45)
                        fontColor: "#4A4646"
                        fontSize: 16 * scaleRatio
                        checked: appWindow.persistentSettings.nettype == NetworkType.STAGENET;
                        onClicked: {
                            persistentSettings.nettype = stageNet.checked ? NetworkType.STAGENET : NetworkType.MAINNET
                            mainNet.checked = false;
                            testNet.checked = false;
                            console.log("Network type set to ", persistentSettings.nettype == NetworkType.STAGENET ? "Stagenet" : "Mainnet")
                        }
                    }
                }
            }

        }
    }
}
