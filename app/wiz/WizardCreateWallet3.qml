import "../mock/Windows.js" as Windows
import "../mock/NetworkType.js" as NetworkType
import "../mock/Settings.js" as Settings
import "../components"
import "../components" as MoneroComponents

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0


Rectangle {
    id: wizardCreateWallet3

    color: "transparent"
    property string viewName: "wizardCreateWallet3"
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
                    text: "Daemon settings"
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
                    text: "To be able to communicate with the Monero network your wallet needs to be connected to a Monero node. For best privacy it's recommended to run your own node."

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

                TextArea {
                    Layout.fillWidth: true
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: MoneroComponents.Style.dimmedFontColor
                    text: "If you don't have the option to run your own node, there's an option to connect to a remote node."

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

        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.maximumWidth: 660
            Layout.alignment: Qt.AlignHCenter
            spacing: 10 * scaleRatio

            RowLayout {
                MoneroComponents.RadioButton {
                    id: localNode
                    text: qsTr("Start a node automatically in background (recommended)") + translationManager.emptyString
                    fontSize: 16 * scaleRatio
                    checked: !appWindow.persistentSettings.useRemoteNode && !isAndroid && !isIOS
                    visible: !isAndroid && !isIOS
                    onClicked: {
                        checked = true;
                        remoteNode.checked = false;
                    }
                }
            }

            ColumnLayout {
                visible: localNode.checked
                id: blockchainFolderRow
                spacing: 20 * scaleRatio

                Layout.topMargin: 8 * scaleRatio
                Layout.fillWidth: true

                MoneroComponents.LineEditMulti {
                    id: blockchainFolder

                    Layout.fillWidth: true

                    text: persistentSettings.blockchainDataDir

                    placeholderText: qsTr("/home/dsc/Monero/data") + translationManager.emptyString
                    placeholderFontSize: 15 * scaleRatio

                    labelText: qsTr("Blockchain location") + translationManager.emptyString
                    labelFontSize: 14 * scaleRatio

                    fontBold: false

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            mouse.accepted = false
                            if(persistentSettings.blockchainDataDir != "")
                                blockchainFileDialog.folder = "file://" + persistentSettings.blockchainDataDir
                            blockchainFileDialog.open()
                            blockchainFolder.focus = true
                        }
                    }
                }

                ColumnLayout {
                    spacing: 8
                    Layout.fillWidth: true
                    Layout.bottomMargin: 12 * scaleRatio

                    MoneroComponents.RemoteNodeEdit {
                        Layout.minimumWidth: 300 * scaleRatio
                        opacity: localNode.checked
                        id: bootstrapNodeEdit

                        labelText: qsTr("Bootstrap node (leave blank if not wanted)") + translationManager.emptyString

                        lineEditBackgroundColor: "transparent"
                        lineEditFontColor: "white"
                        lineEditFontBold: false
                        lineEditBorderColor: Qt.rgba(255, 255, 255, 0.35)
                        labelFontSize: 14 * scaleRatio
                        placeholderFontSize: 15 * scaleRatio

                        daemonAddrText: persistentSettings.bootstrapNodeAddress.split(":")[0].trim()
                        daemonPortText: {
                            var node_split = persistentSettings.bootstrapNodeAddress.split(":");
                            if(node_split.length == 2){
                                (node_split[1].trim() == "") ? "18081" : node_split[1];
                            } else {
                                return ""
                            }
                        }
                    }
                }
            }

            RowLayout {
                MoneroComponents.RadioButton {
                    id: remoteNode
                    text: qsTr("Connect to a remote node") + translationManager.emptyString
                    fontSize: 16 * scaleRatio
                    checked: appWindow.persistentSettings.useRemoteNode
                    onClicked: {
                        checked = true
                        localNode.checked = false
                    }
                }
            }

            MoneroComponents.RemoteNodeEdit {
                Layout.topMargin: 8 * scaleRatio
                Layout.minimumWidth: 300 * scaleRatio
                opacity: remoteNode.checked
                id: remoteNodeEdit

                labelText: qsTr("Remote node details:") + translationManager.emptyString

                lineEditBackgroundColor: "transparent"
                lineEditFontColor: "white"
                lineEditFontBold: false
                lineEditBorderColor: Qt.rgba(255, 255, 255, 0.35)
                labelFontSize: 14 * scaleRatio
                placeholderFontSize: 15 * scaleRatio

                property var rna: daemonOptionsAddress
                daemonAddrText: rna.search(":") != -1 ? rna.split(":")[0].trim() : ""
                daemonPortText: rna.search(":") != -1 ? (rna.split(":")[1].trim() == "") ? "18081" : daemonOptionsAddress.split(":")[1] : ""
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
                        wizardStateView.state = "wizardCreateWallet2";
                    }
                }

                MoneroComponents.StandardButton{
                    text: "Next"

                    Layout.alignment: Qt.AlignRight
                    Layout.preferredWidth: 120 * scaleRatio

                    onClicked: {
                        wizardStateView.state = "wizardCreateWallet4";
                    }
                }
            }
        }
    }
}
