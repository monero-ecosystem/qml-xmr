import "../mock/Windows.js" as Windows
import "../mock/NetworkType.js" as NetworkType
import "../mock/Settings.js" as Settings
import "../components"
import "../components" as MoneroComponents

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0

// @TODO: remove 'jemoeder'


Rectangle {
    id: wizardHome
    color: "transparent"

    property string viewName: "wizardHome"
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
            spacing: 0

            Text {
                text: "Welcome to Monero!"
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

            Text {
                text: "Please select one of the following options:"
                color: MoneroComponents.Style.dimmedFontColor
                // font.pixelSize: (isMobile)? 14 * scaleRatio : 16 * scaleRatio
                Layout.fillWidth: true
                Layout.topMargin: 8 * scaleRatio
                font.pixelSize: {
                    if(wizardController.layoutScale === 2 ){
                        return 16 * scaleRatio;
                    } else {
                        return 14 * scaleRatio;
                    }
                }
            }
        }

        GridLayout {
            id: gridHome
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.topMargin: {
                if(wizardController.layoutScale === 2){
                    return 40 * scaleRatio;
                } else {
                    return 0 * scaleRatio;
                }
            }
            columnSpacing: {
                if(wizardController.layoutScale === 2){
                    return 28;
                } else {
                    return 10;
                }
            }
            columns: {
                if(wizardController.layoutScale === 2){
                    return 4;
                } else if(wizardController.layoutScale === 1){
                    return 2;
                } else {
                    return 1;
                }
            }

            property int buttonSize: {
                if(wizardController.layoutScale === 2){
                    return 128;
                } else if(wizardController.layoutScale === 1){
                    return 100;
                } else {
                    return 70;
                }
            }

            property int buttonImageSize: buttonSize - 10 * scaleRatio
            property int maximumItemHeight: 170
            property string itemBorderColor: "#FFFFFF"
            property string itemBorderColorHover: "#FA6800"
            property int itemAnimationIn: 200
            property int itemAnimationOut: 400

            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                Layout.minimumWidth: 72 * scaleRatio
                Layout.maximumWidth: 200 * scaleRatio
                clip: true

                Rectangle {
                    id: createWallet
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredHeight: gridHome.buttonSize
                    Layout.preferredWidth: gridHome.buttonSize
                    radius: gridHome.buttonSize
                    
                    color: gridHome.itemBorderColor
                    state: "EXITED"
                    states: [
                        State {
                            name: "ENTERED"
                            PropertyChanges { target: createWallet; color: gridHome.itemBorderColorHover}
                        },
                        State {
                            name: "EXITED"
                            PropertyChanges { target: createWallet; color: gridHome.itemBorderColor}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "ENTERED"
                            to: "EXITED"
                            ColorAnimation { target: createWallet; duration: gridHome.itemAnimationOut}
                        },
                        Transition {
                            from: "EXITED"
                            to: "ENTERED"
                            ColorAnimation { target: createWallet; duration: gridHome.itemAnimationIn}
                        }
                    ]

                    Image {
                        width: gridHome.buttonImageSize
                        height: gridHome.buttonImageSize
                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Image.AlignRight
                        verticalAlignment: Image.AlignTop
                        anchors.centerIn: parent
                        source: "../img/createWallet.png"
                    }

                    MouseArea {
                        id: createWalletArea
                        onEntered: createWallet.state = "ENTERED"
                        onExited: createWallet.state = "EXITED"                        
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            wizardStateView.state = "wizardCreateWallet1"
                        }
                    }
                }

                TextArea {
                    Layout.topMargin: 20
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.defaultFontColor
                    text: "Create a new wallet"

                    font.pixelSize: 15 * scaleRatio
                    horizontalAlignment: TextInput.AlignHCenter
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

                TextArea {
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.dimmedFontColor
                    text: "Generate a wallet file"

                    font.pixelSize: 14 * scaleRatio
                    horizontalAlignment: TextInput.AlignHCenter
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

            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                Layout.minimumWidth: 72 * scaleRatio
                Layout.maximumWidth: 200 * scaleRatio
                clip: true

                Rectangle {
                    id: createHardware
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredHeight: gridHome.buttonSize
                    Layout.preferredWidth: gridHome.buttonSize
                    radius: gridHome.buttonSize

                    color: gridHome.itemBorderColor
                    state: "EXITED"
                    states: [
                        State {
                            name: "ENTERED"
                            PropertyChanges { target: createHardware; color: gridHome.itemBorderColorHover}
                        },
                        State {
                            name: "EXITED"
                            PropertyChanges { target: createHardware; color: gridHome.itemBorderColor}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "ENTERED"
                            to: "EXITED"
                            ColorAnimation { target: createHardware; duration: gridHome.itemAnimationOut}
                        },
                        Transition {
                            from: "EXITED"
                            to: "ENTERED"
                            ColorAnimation { target: createHardware; duration: gridHome.itemAnimationIn}
                        }
                    ]

                    Image {
                        width: gridHome.buttonImageSize
                        height: gridHome.buttonImageSize
                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Image.AlignRight
                        verticalAlignment: Image.AlignTop
                        anchors.centerIn: parent
                        source: "../img/createWalletFromDevice.png"
                    }

                    MouseArea {
                        id: createHardwareArea
                        onEntered: createHardware.state = "ENTERED"
                        onExited: createHardware.state = "EXITED" 
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            wizardStateView.state = "wizardTest"
                        }
                    }
                }

                TextArea {
                    Layout.topMargin: 20
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.defaultFontColor
                    text: "Create a new wallet"

                    font.pixelSize: 15 * scaleRatio
                    horizontalAlignment: TextInput.AlignHCenter
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

                TextArea {
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.dimmedFontColor
                    text: "From a hardware device"

                    font.pixelSize: 14 * scaleRatio
                    horizontalAlignment: TextInput.AlignHCenter
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

            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                Layout.minimumWidth: 72 * scaleRatio
                Layout.maximumWidth: 200 * scaleRatio
                clip: true

                Rectangle {
                    id: openAccount
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredHeight: gridHome.buttonSize
                    Layout.preferredWidth: gridHome.buttonSize
                    radius: gridHome.buttonSize
                    color: gridHome.itemBorderColor
                    state: "EXITED"
                    states: [
                        State {
                            name: "ENTERED"
                            PropertyChanges { target: openAccount; color: gridHome.itemBorderColorHover}
                        },
                        State {
                            name: "EXITED"
                            PropertyChanges { target: openAccount; color: gridHome.itemBorderColor}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "ENTERED"
                            to: "EXITED"
                            ColorAnimation { target: openAccount; duration: gridHome.itemAnimationOut}
                        },
                        Transition {
                            from: "EXITED"
                            to: "ENTERED"
                            ColorAnimation { target: openAccount; duration: gridHome.itemAnimationIn}
                        }
                    ]

                    Image {
                        width: gridHome.buttonImageSize
                        height: gridHome.buttonImageSize
                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Image.AlignRight
                        verticalAlignment: Image.AlignTop
                        anchors.centerIn: parent
                        source: "../img/openAccount.png"
                    }

                    MouseArea {
                        id: openAccountArea
                        onEntered: openAccount.state = "ENTERED"
                        onExited: openAccount.state = "EXITED" 
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            wizardStateView.state = "wizardTest"
                        }
                    }
                }

                TextArea {
                    Layout.topMargin: 20
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.defaultFontColor
                    text: "Open a wallet from file"

                    font.pixelSize: 15 * scaleRatio
                    horizontalAlignment: TextInput.AlignHCenter
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

                TextArea {
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.dimmedFontColor
                    text: "From a local wallet file"

                    font.pixelSize: 14 * scaleRatio
                    horizontalAlignment: TextInput.AlignHCenter
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

            ColumnLayout {
                spacing: 0
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                Layout.minimumWidth: 72 * scaleRatio
                Layout.maximumWidth: 200 * scaleRatio
                clip: true

                Rectangle {
                    id: recoverWallet
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredHeight: gridHome.buttonSize
                    Layout.preferredWidth: gridHome.buttonSize
                    radius: gridHome.buttonSize
                    color: gridHome.itemBorderColor
                    state: "EXITED"
                    states: [
                        State {
                            name: "ENTERED"
                            PropertyChanges { target: recoverWallet; color: gridHome.itemBorderColorHover}
                        },
                        State {
                            name: "EXITED"
                            PropertyChanges { target: recoverWallet; color: gridHome.itemBorderColor}
                        }
                    ]

                    transitions: [
                        Transition {
                            from: "ENTERED"
                            to: "EXITED"
                            ColorAnimation { target: recoverWallet; duration: gridHome.itemAnimationOut}
                        },
                        Transition {
                            from: "EXITED"
                            to: "ENTERED"
                            ColorAnimation { target: recoverWallet; duration: gridHome.itemAnimationIn}
                        }
                    ]

                    Image {
                        width: gridHome.buttonImageSize
                        height: gridHome.buttonImageSize
                        fillMode: Image.PreserveAspectFit
                        horizontalAlignment: Image.AlignRight
                        verticalAlignment: Image.AlignTop
                        anchors.centerIn: parent
                        source: "../img/recoverWallet.png"
                    }

                    MouseArea {
                        id: recoverWalletArea
                        onEntered: recoverWallet.state = "ENTERED"
                        onExited: recoverWallet.state = "EXITED" 
                        cursorShape: Qt.PointingHandCursor
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            wizardStateView.state = "wizardTest"
                        }
                    }
                }

                TextArea {
                    Layout.topMargin: 20
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.defaultFontColor
                    text: "Restore wallet"

                    font.pixelSize: 15 * scaleRatio
                    horizontalAlignment: TextInput.AlignHCenter
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

                TextArea {
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.dimmedFontColor
                    text: "From keys or mnemonic seed"

                    font.pixelSize: 14 * scaleRatio
                    horizontalAlignment: TextInput.AlignHCenter
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
        }

        Rectangle {
            Layout.topMargin: 20 * scaleRatio
            Layout.bottomMargin: 0 * scaleRatio
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            color: MoneroComponents.Style.dividerColor
            opacity: MoneroComponents.Style.dividerOpacity
        }

        RowLayout {
            StandardButton {
                id: sendButton
                // rightIcon: "../images/rightArrow.png"
                // rightIconInactive: "../images/rightArrow.png"
                // rightIconMirror: true
                // rightIconMargin: 40
                small: true
                Layout.topMargin: 4 * scaleRatio
                text: qsTr("Language selection") + translationManager.emptyString
                onClicked: {
                    wizardStateView.state = "wizardLanguage"
                }
            }
        }

        RowLayout {
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
