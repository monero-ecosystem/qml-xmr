import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import "../js/Windows.js" as Windows
import "../js/Utils.js" as Utils
import "../mock/Settings.js" as Settings
import "../components" as MoneroComponents
import "../pages"
import "../wiz"

Item {
    id: wizardController
    anchors.fill: parent

    function resetOptions(){
        walletOptionsName = '';
        walletOptionsLocation = '/home/dsc/Monero/wallets';
        walletOptionsPassword = '';
        walletOptionslanguage = '';
        walletOptionsSeed = '';
        walletOptionsBackup = '';
    }

    property string walletOptionsName: 'testwallet'
    property string walletOptionsLocation: '/home/dsc/Monero/wallets'
    property string walletOptionsPassword: 'test123'
    property string walletOptionsLanguage: persistentSettings.language
    property string walletOptionsSeed: ''
    property string walletOptionsBackup: ''
    property string walletOptionsBootstrapAddress: persistentSettings.bootstrapNodeAddress
    property string daemonOptionsAddress: persistentSettings.remoteNodeAddress
    property string daemonOptionsNetType: {
        if(currentWallet.nettype === 1){
            return 'Mainnet';
        }
    }

    property int layoutScale: {
        if(isMobile){
            return 0;
        } else if(appWindow.width < 800){
            return 1;
        } else {
            return 2;
        }
    }

    Image {
        opacity: 1.0
        anchors.fill: parent
        source: "../images/middlePanelBg.jpg"
    }

    Rectangle {
        id: wizardStateView
        property Item currentView
        property Item previousView
        property WizardLanguage wizardLanguageView: WizardLanguage { }
        property WizardHome wizardHomeView: WizardHome { }
        property WizardCreateWallet1 wizardCreateWallet1View: WizardCreateWallet1 { }
        property WizardCreateWallet2 wizardCreateWallet2View: WizardCreateWallet2 { }
        property WizardCreateWallet3 wizardCreateWallet3View: WizardCreateWallet3 { }
        property WizardCreateWallet4 wizardCreateWallet4View: WizardCreateWallet4 { }
        anchors.fill: parent

        signal previousClicked;

        // Layout.preferredWidth: wizardController.width
        // Layout.preferredHeight: wizardController.height
        color: "transparent"
        state: ''

        onPreviousClicked: {
            if (previousView && previousView.viewName != null){
                state = previousView.viewName;
            } else {
                state = "wizardHome";
            }
        }

        onCurrentViewChanged: {
            if (previousView) {
               if (typeof previousView.onPageClosed === "function") {
                   previousView.onPageClosed();
               }
            }

            previousView = currentView;
            if (currentView) {
                stackView.replace(currentView)
                // Component.onCompleted is called before wallet is initilized
//                if (typeof currentView.onPageCompleted === "function") {
//                    currentView.onPageCompleted();
//                }
            }
        }

        states: [
            State {
                name: "wizardLanguage"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardLanguageView }
            }, State {
                name: "wizardHome"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardHomeView }
            }, State {
                name: "wizardCreateWallet1"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardCreateWallet1View }
            }, State {
                name: "wizardCreateWallet2"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardCreateWallet2View }
            }, State {
                name: "wizardCreateWallet3"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardCreateWallet3View }
            }, State {
                name: "wizardCreateWallet4"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardCreateWallet4View }
            }
        ]

        StackView {
            id: stackView
            initialItem: wizardStateView.wizardCreateWallet4View;
            anchors.fill: parent
            clip: false

            delegate: StackViewDelegate {
                pushTransition: StackViewTransition {
                    PropertyAnimation {
                        target: enterItem
                        property: "x"
                        from: target.width
                        to: 0
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "x"
                        from: 0
                        to: 0 - target.width
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
        Component.onCompleted: {

        }
	}
}
