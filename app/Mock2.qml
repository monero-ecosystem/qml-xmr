import "mock/Windows.js" as Windows
import "components"
import "components" as MoneroComponents

import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.0


Rectangle{
    anchors.fill: parent
    color: "black"

    Image {
        opacity: 1.0
        anchors.fill: parent
        source: "images/middlePanelBg.jpg"
    }

    ColumnLayout {
        id: root
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 100 * scaleRatio
        anchors.leftMargin: 100 * scaleRatio
        anchors.rightMargin: 100 * scaleRatio
        spacing: 30 * scaleRatio

        Rectangle {
            color: "transparent"
            anchors.fill: parent
        }

        Text {
            // anchors.horizontalCenter: parent.horizontalCenter
            Layout.topMargin: 32 * scaleRatio
            text: "How do you want to start?"
            color: "white"
            font.pixelSize: 36 * scaleRatio
        }

        GridLayout {
            columns: (isMobile)? 1 : 3
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.fillWidth: true
            columnSpacing: 92 * scaleRatio

            ColumnLayout {
                spacing: 0
                Layout.fillWidth: true
                //Layout.preferredHeight: 160

                Item {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.preferredWidth: 60 * scaleRatio
                    Layout.preferredHeight: 60 * scaleRatio

                    Image {
                        id: xx
                        width: 60 * scaleRatio
                        height: 60 * scaleRatio
                        source: "img/local.png"
                        state: "exited"

                        states: [
                            State {
                                name: "hover"
                                PropertyChanges { target: xx; width: 54 }
                                PropertyChanges { target: xx; height: 54 }
                            }, State {
                                name: "exited"
                                PropertyChanges { target: xx; width: 60 }
                                PropertyChanges { target: xx; height: 60 }
                            }
                        ]

                        NumberAnimation { id: anim; duration: 200; easing.type: Easing.OutCubic }
                        Behavior on width { animation: anim }
                        Behavior on height { animation: anim }
                    }
                }

                Text {
                    Layout.topMargin: 70
                    text: "Create a new wallet"
                    font.pixelSize: 15 * scaleRatio
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        xx.state = "hover"
                    }
                    onExited: {
                        xx.state = "exited"
                    }
                    onClicked: {
                        console.log('x2');
                    }
                }
            }

            ColumnLayout {
                spacing: 0
                Layout.fillWidth: true
                Layout.preferredHeight: 150

                Item {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 60

                    Image {
                        id: xx2
                        width: 60
                        height: 60
                        source: "img/local.png"
                        state: "exited"

                        states: [
                            State {
                                name: "hover"
                                PropertyChanges { target: xx2; width: 54 }
                                PropertyChanges { target: xx2; height: 54 }
                            }, State {
                                name: "exited"
                                PropertyChanges { target: xx2; width: 60 }
                                PropertyChanges { target: xx2; height: 60 }
                            }
                        ]

                        NumberAnimation { id: anim2; duration: 200; easing.type: Easing.OutCubic }
                        Behavior on width { animation: anim2 }
                        Behavior on height { animation: anim2 }
                    }
                }

                Text {
                    Layout.topMargin: 70
                    text: "Restore wallet"
                    font.pixelSize: 15 * scaleRatio
                    color: "white"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    Layout.topMargin: 8 * scaleRatio
                    text: "From keys or mnemonic seed"
                    color: "#c0c0c0"
                    font.pixelSize: 14 * scaleRatio
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered: {
                        xx2.state = "hover"
                    }
                    onExited: {
                        xx2.state = "exited"
                    }
                    onClicked: {
                        console.log('x2');
                    }
                }
            }

            ColumnLayout {
                spacing: 0
                Layout.fillWidth: true
                Layout.preferredHeight: 150

                Item {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 60

                    Image {
                        id: xx3
                        width: 60
                        height: 60
                        source: "img/local.png"
                        state: "exited"

                        states: [
                            State {
                                name: "hover"
                                PropertyChanges { target: xx3; width: 54 }
                                PropertyChanges { target: xx3; height: 54 }
                            }, State {
                                name: "exited"
                                PropertyChanges { target: xx3; width: 60 }
                                PropertyChanges { target: xx3; height: 60 }
                            }
                        ]

                        NumberAnimation { id: anim3; duration: 200; easing.type: Easing.OutCubic }
                        Behavior on width { animation: anim3 }
                        Behavior on height { animation: anim3 }
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
                    onEntered: {
                        xx3.state = "hover"
                    }
                    onExited: {
                        xx3.state = "exited"
                    }
                    onClicked: {
                        console.log('x2');
                    }
                }
            }
        }

        Rectangle {
            Layout.topMargin: 30 * scaleRatio
            Layout.bottomMargin: 0 * scaleRatio
            Layout.preferredHeight: 1
            Layout.fillWidth: true
            color: MoneroComponents.Style.dividerColor
            opacity: MoneroComponents.Style.dividerOpacity
        }

        MoneroComponents.CheckBox2 {
            id: showAdvancedCheckbox
            Layout.fillWidth: true
            checked: false
            onClicked: {
                console.log('Advanced options')
            }
            text: qsTr("Advanced options") + translationManager.emptyString
        }

        RowLayout{
            visible: showAdvancedCheckbox.checked

            
            // MoneroComponents.RemoteNodeEdit {
            //     id: bootstrapNodeEdit
            //     visible: showAdvancedCheckbox.checked
            //     Layout.fillWidth: true

            //     lineEditBackgroundColor: "transparent"
            //     lineEditFontColor: "white"
            //     lineEditBorderColor: Style.inputBorderColorActive

            //     daemonAddrLabelText: qsTr("Address") + translationManager.emptyString
            //     daemonPortLabelText: qsTr("Port") + translationManager.emptyString
            //     daemonAddrText: persistentSettings.bootstrapNodeAddress.split(":")[0].trim()
            //     daemonPortText: {
            //         var node_split = persistentSettings.bootstrapNodeAddress.split(":");
            //         if(node_split.length == 2){
            //             (node_split[1].trim() == "") ? "18081" : node_split[1];
            //         } else {
            //             return ""
            //         }
            //     }
            //     onEditingFinished: {
            //         persistentSettings.bootstrapNodeAddress = daemonAddrText ? bootstrapNodeEdit.getAddress() : "";
            //         console.log("setting bootstrap node to " + persistentSettings.bootstrapNodeAddress)
            //     }
            // }
        }
    }
}
