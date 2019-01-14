import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

import "."
import "components"
import "components" as MoneroComponents
import "mock/Windows.js" as Windows
import "mock/Version.js" as Version
import "mock/NetworkType.js" as NetworkType
import "mock/Settings.js" as Settings
import "mock"

ApplicationWindow {
    id: appWindow
    title: "Monero"
    width: 940
    height: 800

    // mocks
    property var watcher
    property var currentItem
    property bool whatIsEnable: false
    property bool ctrlPressed: false
    property bool rightPanelExpanded: false
    property bool osx: false
    property var transaction;
    property var transactionDescription;
    property var walletPassword
    property var oshelper: {
        "temporaryFilename": function(){
            return '/tmp/mocked_wallet'
        }
    }
    property var m_wallet: {}
    property bool isNewWallet: false
    property int restoreHeight:0
    property bool daemonSynced: false
    property bool isAndroid: false
    property bool isIOS: false
    property bool walletSynced: false
    property int screenHeight: appWindow.height
    property int maxWindowHeight: (isAndroid || isIOS)? screenHeight : (screenHeight < 900)? 720 : 800;
    property bool daemonRunning: false
    property var toolTip
    property string walletName: "dsc"
    property bool viewOnly: false
    property bool foundNewBlock: false
    property int timeToUnlock: 0
    property bool qrScannerEnabled: true
    property int blocksToSync: 1
    property var cameraUi
    property bool remoteNodeConnected: false
    property bool androidCloseTapped: false;
    // Default daemon addresses
    property string defaultAccountName: "dsc"
    property string moneroAccountsDir: "/home/dsc/Monero/wallets"
    readonly property string localDaemonAddress : persistentSettings.nettype == 0 ? "localhost:18081" : persistentSettings.nettype == 1 ? "localhost:28081" : "localhost:38081"
    property string currentDaemonAddress;
    property bool startLocalNodeCancelled: false
    property int estimatedBlockchainSize: 50 // GB
    property double scaleRatio: 1.0
    property bool isMobile: false
    property var walletLogPath: "/home/dsc/.config/Monero/monero-core.conf"
    // property var qtRuntimeVersion: qt_version_str
    property var qtRuntimeversion: "5.7.1"
    property var persistentSettings: {
        "customDecorations": true,
        'useRemoteNode': false,
        "daemonFlags": "--log testflag",
        "logLevel": 2,
        "language": "English (US)",
        "locale": "en_US",
        "remoteNodeAddress": "",
        "bootstrapNodeAddress": "",
        "blockchainDataDir": "",
        "nettype": NetworkType.STAGENET
    }

    property var daemonManager: {
        "sendCommand": function(){
            return 'ok';
        },
        "validateDataDir": function(x){
            return {
                'valid': false
            };
        }
    }
    property var appWindow: {
        "disconnectRemoteNode": function(){
            persistentSettings.useRemoteNode = false;
        },
        "connectRemoteNode": function(){
            persistentSettings.useRemoteNode = true;
        },
        "persistentSettings": persistentSettings
    }
    property var currentWallet: {
        "nettype": 1,
        "walletCreationHeight": 1400
    }
    property var walletManager: {
        "setLogLevel": function(x){
            persistentSettings.logLevel = x;
        },
        "walletExists": function(x){
            return false;
        },
        "localPathToUrl": function(x){
            return x;
        },
        "getPasswordStrength": function(x){
            return x.length * 10;
        },
        "urlToLocalPath": function(x){
            return x;
        },
        "createWallet": function(a,b,c,d,e){
            return {
                'seed': "joining hull estate tanks cube vain lamb jerseys kettle usual nerves wobbly opacity faulty succeed meeting stellar threaten gasp dialect ridges deity hairy injury threaten"
            }
        }
    }
    property var translationManager: {
        'emptyString': '',
        'setLanguage': function(lang){
            console.log('setLanguage() -> ' + lang)
        }
    };

    objectName: "appWindow"
    visible: true
    color: "black"
    // flags: persistentSettings.customDecorations ? Windows.flagsCustomDecorations : Windows.flags
    flags: Windows.flagsCustomDecorations
    
    // mock.qml
    Mock{}

    MouseArea {
        id: resizeArea
        hoverEnabled: true
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 30
        width: 30

        Rectangle {
            anchors.fill: parent
            color: parent.containsMouse || parent.pressed ? "#111111" : "transparent"
        }

        Image {
            anchors.centerIn: parent
            source: parent.containsMouse || parent.pressed ? "images/resizeHovered.png" :
                                                             "images/resize.png"
        }

        property var previousPosition

        onPressed: {
            previousPosition = globalCursor.getPosition()
        }

        onPositionChanged: {
            if(!pressed) return;
            var pos = globalCursor.getPosition()
            //var delta = previousPosition - pos
            var dx = previousPosition.x - pos.x
            var dy = previousPosition.y - pos.y

            if(appWindow.width - dx > parent.minWidth)
                appWindow.width -= dx
            else appWindow.width = parent.minWidth

            if(appWindow.height - dy > parent.minHeight)
                appWindow.height -= dy
            else appWindow.height = parent.minHeight
            previousPosition = pos
        }
    }

    TitleBar {
        id: titleBar
        x: 0
        y: 0
        anchors.left: parent.left
        anchors.right: parent.right
        showMinimizeButton: true
        showMaximizeButton: true
        showWhatIsButton: false
        showMoneroLogo: true
        onCloseClicked: appWindow.close();
        onMaximizeClicked: {
            appWindow.visibility = appWindow.visibility !== Window.FullScreen ? Window.FullScreen :
                                                                                Window.Windowed
        }
        onMinimizeClicked: appWindow.visibility = Window.Minimized
        onGoToBasicVersion: {
            if (yes) {
                // basicPanel.currentView = middlePanel.currentView
                goToBasicAnimation.start()
            } else {
                // middlePanel.currentView = basicPanel.currentView
                goToProAnimation.start()
            }
        }

        MouseArea {
            enabled: persistentSettings.customDecorations
            property var previousPosition
            anchors.fill: parent
            propagateComposedEvents: true
            onPressed: previousPosition = globalCursor.getPosition()
            onPositionChanged: {
                if (pressedButtons == Qt.LeftButton) {
                    var pos = globalCursor.getPosition()
                    var dx = pos.x - previousPosition.x
                    var dy = pos.y - previousPosition.y

                    appWindow.x += dx
                    appWindow.y += dy
                    previousPosition = pos
                }
            }
        }
    }

    function releaseFocus(){
        return;
    }

    function qStr(inp){
        return inp;
    }

    function showStatusMessage(x){
        console.log("show status message: " + x);
    }

    Component.onCompleted: {
        console.log("Started AppWindow");
        console.log("QT runtime: " + appWindow.qtRuntimeVersion);

        // function createTimer(ms){
        //     return Qt.createQmlObject("import QtQuick 2.7; import QtQuick.Layouts 1.2; import QtQuick.Controls 2.0; Timer { interval: "+ms+"; running: true; repeat: true; signal onTriggeredState; onTriggered: onTriggeredState(); }", appWindow);
        //     // var ctx = Qt.createComponent(timer);
        // }
    }

    // Choose blockchain folder
    FileDialog {
        id: blockchainFileDialog
        property string directory: ""
        signal changed();

        title: "Please choose a folder"
        selectFolder: true
        folder: "file://" + persistentSettings.blockchainDataDir

        onRejected: console.log("data dir selection canceled")
        onAccepted: {
            var dataDir = walletManager.urlToLocalPath(blockchainFileDialog.fileUrl)
            var validator = daemonManager.validateDataDir(dataDir);
            if(validator.valid) {
                persistentSettings.blockchainDataDir = dataDir;
            } else {
                confirmationDialog.title = qsTr("Warning") + translationManager.emptyString;
                confirmationDialog.text = "";
                if(validator.readOnly)
                    confirmationDialog.text  += qsTr("Error: Filesystem is read only") + "\n\n"
                if(validator.storageAvailable < 20)
                    confirmationDialog.text  += qsTr("Warning: There's only %1 GB available on the device. Blockchain requires ~%2 GB of data.").arg(validator.storageAvailable).arg(estimatedBlockchainSize) + "\n\n"
                else
                    confirmationDialog.text  += qsTr("Note: There's %1 GB available on the device. Blockchain requires ~%2 GB of data.").arg(validator.storageAvailable).arg(estimatedBlockchainSize) + "\n\n"
                if(!validator.lmdbExists)
                    confirmationDialog.text  += qsTr("Note: lmdb folder not found. A new folder will be created.") + "\n\n"

                confirmationDialog.icon = StandardIcon.Question
                confirmationDialog.cancelText = qsTr("Cancel")

                // Continue
                confirmationDialog.onAcceptedCallback = function() {
                    persistentSettings.blockchainDataDir = dataDir
                }

                // Cancel
                confirmationDialog.onRejectedCallback = function() { };
                confirmationDialog.open()
            }

            blockchainFileDialog.directory = blockchainFileDialog.fileUrl;
            delete validator;
        }
    }

    StandardDialog {
        z: parent.z + 1
        id: confirmationDialog
        anchors.fill: parent
        property var onAcceptedCallback
        property var onRejectedCallback
        onAccepted:  {
            if (onAcceptedCallback)
                onAcceptedCallback()
        }
        onRejected: {
            if (onRejectedCallback)
                onRejectedCallback();
        }
    }


    MoneroComponents.LanguageSidebar {
        id: languageSidebar
    }
}
