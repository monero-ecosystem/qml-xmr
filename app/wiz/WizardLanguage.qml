import "../mock/Windows.js" as Windows
import "../components"
import "../components" as MoneroComponents

import QtQuick 2.7
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.0


Rectangle {
    Layout.fillWidth: true
    color: "black"

    Image {
        opacity: sideBar.position == 0 ? 1.0 : 0.2
        anchors.fill: parent
        source: "../images/middlePanelBg.jpg"
    }

    ColumnLayout {
        id: root
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 30 * scaleRatio

        Drawer {
            id: sideBar
            width: 240
            height: parent.height - 50
            y: titleBar.height
            background: Rectangle {
                color: "#0d0d0d"
                width: parent.width - 1 // dirty hacky
            }

            ColumnLayout {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 0

                ListView {
                    clip: true
                    anchors.top: parent.top
                    width: sideBar.width
                    height: sideBar.height

                    // model: Qt.fontFamilies()
                    model: langModel

                    delegate: ColumnLayout {
                        width: sideBar.width
                        spacing: 0

                        Text {
                            Layout.topMargin: 8
                            Layout.bottomMargin: 8
                            Layout.leftMargin: 20
                            font.bold: true
                            font.pixelSize: 14 * scaleRatio
                            color: MoneroComponents.Style.defaultFontColor
                            text: display_name
                        }

                        Rectangle {
                            color: MoneroComponents.Style.dividerColor
                            opacity: MoneroComponents.Style.dividerOpacity
                            Layout.preferredHeight: 1
                            Layout.fillWidth: true
                        }

                        // button gradient while checked
                        Image {
                            anchors.fill: parent
                            source: "../images/menuButtonGradient.png"
                            opacity: 0.75
                            visible: true

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    translationManager.setLanguage(locale.split("_")[0]);
                                    sideBar.close()
                                }
                            }
                        }
                    }

                    ScrollIndicator.vertical: ScrollIndicator {
                        // #TODO: QT 5.9 introduces `policy: ScrollBar.AlwaysOn`
                        active: true
                        contentItem.opacity: 0.7
                        onActiveChanged: {
                            if (!active) {
                                active = true;
                            }
                        }
                    }
                }
            }

            // NumberAnimation { id: anim; duration: 200; easing.type: Easing.OutCubic }
            // Behavior on width { animation: anim }
        }

        Rectangle {
            // some margins for the titlebar
            visible: appWindow.persistentSettings.customDecorations
            Layout.topMargin: 90
            Layout.fillWidth: true
            Layout.preferredHeight: 0
            color: "transparent"
        }

        TextArea {
            id: textWelcome
            opacity: 0
            Layout.preferredWidth: parent.width / 1.3
            anchors.horizontalCenter: parent.horizontalCenter
            color: MoneroComponents.Style.defaultFontColor
            text: "Welcome - Wilkommen - Bonvenon - Bienvenido - Bienvenue - Välkommen - Selamat datang - Benvenuto - 歡迎 - Welkom - Bem Vindo - добро пожаловать"

            // font.family: MoneroComponents.Style.fontRegular.name
            font.bold: true
            font.pixelSize: 16 * scaleRatio
            horizontalAlignment: TextInput.AlignHCenter
            selectByMouse: false
            wrapMode: Text.WordWrap
            textMargin: 0
            leftPadding: 0
            topPadding: 0
            readOnly: true

            Behavior on opacity {
                NumberAnimation {
                    duration: 350;
                    easing.type: Easing.InCubic;
                }
            }
        }

        Image {
            id: globe
            source: "../img/world-flags-globe.png"
            opacity: 0
            property bool small: appWindow.width < 700 ? true : false
            property int size: {
                if(small){
                    return 196;
                } else {
                    return 312;
                }
            }
            Layout.preferredWidth: size
            Layout.preferredHeight: size
            anchors.horizontalCenter: parent.horizontalCenter
            mipmap: true

            property bool animSlow: false
            property int animSpeedSlow: 4000
            property int animSpeedNormal: 120000
            property real animFrom: 0
            property real animTo: 360

            Rectangle {
                visible: !globe.small
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 117
                anchors.topMargin: 71
                width: 36
                height: 40
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        anim.stop();
                        globe.animFrom = globe.rotation;
                        globe.animTo = globe.animFrom + 360;
                        anim.duration = globe.animSlow ? globe.animSpeedNormal : globe.animSpeedSlow;
                        globe.animSlow = !globe.animSlow;
                        anim.start();
                    }
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 450;
                    easing.type: Easing.InCubic;
                }
            }

            RotationAnimation on rotation {
                id: anim
                loops: Animation.Infinite
                from: globe.animFrom
                to: globe.animTo
                duration: globe.animSpeedNormal
            }
        }

        ListModel {
            id: langModel

            // Note that wallet_language is not the wallet language but the mnemonic seed language!
            // List of languages for which a mnemonic seed word list is available:
            // English
            // Nederlands  (Dutch)
            // Français    (French)
            // Español     (Spanish)
            // Português   (Portuguese)
            // 日本語          (Japanese)
            // Italiano    (Italian)
            // Deutsch     (German)
            // русский язык    (Russian)
            // 简体中文 (中国)  (Chinese (Simplified)
            // Esperanto
            // Lojban

            Component.onCompleted: {
                append({"display_name": "English (US)", "locale": "en_US", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Deutsch", "locale": "de_DE", "wallet_language": "Deutsch", "qs": "none"});
                append({"display_name": "Esperanto", "locale": "eo", "wallet_language": "Esperanto", "qs": "none"});
                append({"display_name": "Español", "locale": "es_ES", "wallet_language": "Español", "qs": "none"});
                append({"display_name": "Français", "locale": "fr_FR", "wallet_language": "Français", "qs": "none"});
                append({"display_name": "Svenska", "locale": "sv_SE", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Hrvatski", "locale": "hr_HR", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Bahasa Indonesia", "locale": "id_ID", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Italiano", "locale": "it_IT", "wallet_language": "Italiano", "qs": "none"});
                append({"display_name": "日本語", "locale": "ja_JP", "wallet_language": "日本語", "qs": "none"});
                append({"display_name": "Nederlands", "locale": "nl_NL", "wallet_language": "Nederlands", "qs": "none"});
                append({"display_name": "Polski", "locale": "pl_PL", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Português (PT)", "locale": "pt-pt_PT", "wallet_language": "Português", "qs": "none"});
                append({"display_name": "Português (BR)", "locale": "pt-br_BR", "wallet_language": "Português", "qs": "none"});
                append({"display_name": "Русский язык", "locale": "ru_RU", "wallet_language": "русский язык", "qs": "none"});
                append({"display_name": "简体中文 (中国)", "locale": "zh-cn_CN", "wallet_language": "简体中文 (中国)", "qs": "none"});
                append({"display_name": "繁體中文 (台灣)", "locale": "zh-tw_CN", "wallet_language": "English", "qs": "none"});
                append({"display_name": "עברית", "locale": "he_HE", "wallet_language": "English", "qs": "none"});
                append({"display_name": "한국어", "locale": "ko_KO", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Română", "locale": "ro_RO", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Dansk", "locale": "da_DK", "wallet_language": "None", "qs": "none"});
                append({"display_name": "Česky", "locale": "cs_CZ", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Slovensky", "locale": "sk_SK", "wallet_language": "English", "qs": "none"});
                append({"display_name": "العربية", "locale": "ar_AR", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Slovenski", "locale": "sl_SI", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Srpski", "locale": "rs_RS", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Català", "locale": "cat_ES", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Türkçe", "locale": "tr_TR", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Українська", "locale": "uk_UA", "wallet_language": "English", "qs": "none"});
                append({"display_name": "Lietuvių", "locale": "lt_LT", "wallet_language": "English", "qs": "none"});
            }
        }

        GridLayout {
            id: buttonsGrid
            opacity: 0
            columns: (isMobile)? 1 : 2
            anchors.horizontalCenter: parent.horizontalCenter
            Layout.topMargin: 20
            Layout.fillWidth: true
            columnSpacing: 20

            MoneroComponents.StandardButton {
                id: idChangeLang
                Layout.minimumWidth: 150
                text: "Language"

                onClicked: {
                    sideBar.open();
                }
            }

            MoneroComponents.StandardButton {
                id: btnContinue
                Layout.minimumWidth: 150
                text: "Continue"

                onClicked: {
                    console.log('x');
                    wizardStateView.state = "Home"
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 350;
                    easing.type: Easing.InCubic;
                }
            }
        }

        Text {
            id: versionText
            opacity: 0
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            font.pixelSize: 12 * scaleRatio
            color: MoneroComponents.Style.greyFontColor
            text: "v0.12.3.0"

            Behavior on opacity {
                NumberAnimation {
                    duration: 350;
                    easing.type: Easing.InCubic;
                }
            }
        }
    }

    Component.onCompleted: {
        // opacity effects
        delay(textTimer, 100, function() {
            textWelcome.opacity = 1;
        });

        delay(globeTimer, 150, function() {
            globe.opacity = 1;
        });

        delay(buttonTimer, 250, function() {
            buttonsGrid.opacity = 1;
        });

        delay(versionTimer, 350, function() {
            versionText.opacity = 1;
        });
    }

    function delay(timer, interval, cb) {
        timer.interval = interval;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    Timer {
        id: globeTimer
    }

    Timer {
        id: textTimer
    }

    Timer {
        id: buttonTimer
    }

    Timer {
        id: versionTimer
    }
}