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
        property WizardTest wizardTestView: WizardTest { }
        anchors.fill: parent

        signal previousClicked;

        // Layout.preferredWidth: wizardController.width
        // Layout.preferredHeight: wizardController.height
        color: "transparent"
        state: Settings._defaultState

        onPreviousClicked: {
            if (previousView && previousView.viewName != null){
                console.log('dynamic');
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
            console.log('set');
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
                name: "wizardTest"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardTestView }
            }
        ]

        StackView {
            id: stackView
            initialItem: wizardStateView.wizardTestView;
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