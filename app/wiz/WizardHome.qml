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
    Layout.fillWidth: true
    color: "transparent"
    property string fontColorDimmed: "#c0c0c0"
    // Rectangle {
    //     color: "#242424"
    //     anchors.fill: parent
    // }

    // Image {
    //     opacity: 1.0
    //     anchors.fill: parent
    //     source: "../images/middlePanelBg.jpg"
    // }

    // Rectangle {
    //     Layout.topMargin: 0 * scaleRatio
    //     Layout.bottomMargin: 0 * scaleRatio
    //     Layout.preferredHeight: 5
    //     Layout.fillWidth: true
    //     color: MoneroComponents.Style.dividerColor
    //     opacity: MoneroComponents.Style.dividerOpacity
    // }

    ColumnLayout {
        id: root
        
        // anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        spacing: 0 * scaleRatio

        Text {
            text: "Welcome to Monero!"
            color: "white"
            font.pixelSize: (isMobile)? 16 * scaleRatio : 36 * scaleRatio
            Layout.fillWidth: true
        }

        Text {
            text: "Please select one of the following options:"
            color: wizardHome.fontColorDimmed
            font.pixelSize: (isMobile)? 14 * scaleRatio : 16 * scaleRatio
            Layout.fillWidth: true
            Layout.topMargin: 8 * scaleRatio
        }

        GridLayout {
            columns: (isMobile)? 1 : 3
            Layout.fillWidth: true
            // anchors.horizontalCenter: parent.horizontalCenter
            columnSpacing: 92 * scaleRatio

            ColumnLayout {
                spacing: 0

                Layout.fillWidth: true
                Layout.minimumWidth: 72 * scaleRatio
                Layout.maximumWidth: 120 * scaleRatio
                Layout.preferredHeight: height

                id: xx35

                Image {
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "../img/wizardWallet.png"
                }

                Text {
                    Layout.topMargin: 20
                    Layout.fillWidth: true
                    
                    text: "Create a new wallet"
                    font.pixelSize: 15 * scaleRatio
                    color: "white"
                }

                Text {
                    Layout.topMargin: 8 * scaleRatio
                    Layout.fillWidth: true

                    text: ""
                    font.pixelSize: 14 * scaleRatio
                }


                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log('x1');
                        wizardStateView.state = "wizardTest";
                    }
                }
            }

            // ColumnLayout {
            //     spacing: 0
            //     Layout.fillWidth: true

            //     Image {
            //         anchors.horizontalCenter: parent.horizontalCenter
            //         anchors.verticalCenter: parent.verticalCenter
            //         Layout.preferredWidth: 50
            //         Layout.preferredHeight: 50
                    
            //         source: "../img/local@3x.png"
            //     }

            //     Text {
            //         Layout.topMargin: 70
            //         anchors.horizontalCenter: parent.horizontalCenter
            //         text: "Restore wallet"
            //         font.pixelSize: 15 * scaleRatio
            //         color: "white"
            //     }

            //     Text {
            //         Layout.topMargin: 8 * scaleRatio
            //         anchors.horizontalCenter: parent.horizontalCenter
            //         text: "From keys or mnemonic seed"
            //         color: wizardHome.fontColorDimmed
            //         font.pixelSize: 14 * scaleRatio
            //     }

            //     MouseArea{
            //         anchors.fill: parent
            //         hoverEnabled: true
            //         cursorShape: Qt.PointingHandCursor
            //         onClicked: {
            //             console.log('x2');
            //         }
            //     }
            // }

            // ColumnLayout {
            //     spacing: 0
            //     Layout.fillWidth: true

            //     Item {
            //         anchors.horizontalCenter: parent.horizontalCenter
            //         anchors.verticalCenter: parent.verticalCenter
            //         Layout.preferredWidth: 50
            //         Layout.preferredHeight: 50

            //         Image {
            //             id: xx35
            //             width: 41
            //             height: 50
            //             source: "../img/remote@3x.png"
            //         }
            //     }

            //     Text {
            //         Layout.topMargin: 70
            //         text: "Open an existing wallet"
            //         font.pixelSize: 15 * scaleRatio
            //         color: "white"
            //         anchors.horizontalCenter: parent.horizontalCenter
            //     }

            //     Text {
            //         Layout.topMargin: 8 * scaleRatio
            //         text: "From a local wallet file"
            //         color: wizardHome.fontColorDimmed
            //         font.pixelSize: 14 * scaleRatio
            //         anchors.horizontalCenter: parent.horizontalCenter
            //     }

            //     MouseArea {
            //         anchors.fill: parent
            //         hoverEnabled: true
            //         cursorShape: Qt.PointingHandCursor
            //         onClicked: {
            //             console.log('x3');
            //         }
            //     }
            // }
        }

        Rectangle {
            Layout.topMargin: 30 * scaleRatio
            Layout.bottomMargin: 30 * scaleRatio
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            color: MoneroComponents.Style.dividerColor
            opacity: MoneroComponents.Style.dividerOpacity
        }

        MoneroComponents.StandardButton {
            text: "pick language"
            small: true
            onClicked: {
                wizardStateView.state = "wizardLanguage"
            }
        }

        MoneroComponents.StandardButton {
            text: "height"
            small: true
            onClicked: {
                console.log(xx35.height);
            }
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

                ColumnLayout {
                    Layout.fillWidth: true
                    MoneroComponents.Label {
                        id: transactionPriority
                        Layout.topMargin: 14
                        text: qsTr("Transaction priority") + translationManager.emptyString
                        fontBold: false
                        fontSize: 16
                    }
                    // Note: workaround for translations in listElements
                    // ListElement: cannot use script for property value, so
                    // code like this wont work:
                    // ListElement { column1: qsTr("LOW") + translationManager.emptyString ; column2: ""; priority: PendingTransaction.Priority_Low }
                    // For translations to work, the strings need to be listed in
                    // the file components/StandardDropdown.qml too.

                    // Priorites after v5
                    ListModel {
                        id: jemoeder

                        ListElement { column1: qsTr("Mainnet") ; column2: ""; nettype: "mainnet"}
                        ListElement { column1: qsTr("Stagenet") ; column2: ""; nettype: "stagenet"}
                        ListElement { column1: qsTr("Testnet") ; column2: ""; nettype: "testnet"}

                        Component.onCompleted: {
                            // append({"display_name": "English (US)", "locale": "en_US", "wallet_language": "English", "qs": "none"});
                            // append({"display_name": "Deutsch", "locale": "de_DE", "wallet_language": "Deutsch", "qs": "none"});
                            // append({"display_name": "Esperanto", "locale": "eo", "wallet_language": "Esperanto", "qs": "none"});
                            // append({"display_name": "Español", "locale": "es_ES", "wallet_language": "Español", "qs": "none"});
                        }
                    }

                    MoneroComponents.StandardDropdown {
                        dataModel: jemoeder
                        Layout.fillWidth: true
                        Layout.topMargin: 6
                        shadowReleasedColor: "#FF4304"
                        shadowPressedColor: "#B32D00"
                        releasedColor: "#363636"
                        pressedColor: "#202020"

                        onChanged: {                            
                            var item = dataModel.get(currentIndex).nettype.toLowerCase();
                            if(item === "mainnet"){
                                persistentSettings.nettype = NetworkType.MAINNET
                            } else if(item === "stagenet"){
                                persistentSettings.nettype = NetworkType.STAGENET
                            } else if(item === "testnet"){
                                persistentSettings.nettype = NetworkType.TESTNET
                            }
                        }
                    }

                    // Make sure dropdown is on top
                    z: parent.z + 1
                }
            }
        }
    }
}
