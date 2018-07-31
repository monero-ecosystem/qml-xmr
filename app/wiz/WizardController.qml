import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import "../js/Windows.js" as Windows
import "../js/Utils.js" as Utils
import "../js/Settings.js" as Settings
import "../components" as MoneroComponents
import "../pages"
import "../wiz"

Item {
    id: wizardController
    anchors.fill: parent

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
        anchors.fill: parent

        Component.onCompleted: {

        }

        // Layout.preferredWidth: wizardController.width
        // Layout.preferredHeight: wizardController.height
        color: "transparent"
        state: Settings.currentState

        onCurrentViewChanged: {
            if (previousView) {
//                if (typeof previousView.onPageClosed === "function") {
//                    previousView.onPageClosed();
//                }
            }
            previousView = currentView
            if (currentView) {
                stackView.replace(currentView)
                // Component.onCompleted is called before wallet is initilized
//                if (typeof currentView.onPageCompleted === "function") {
//                    currentView.onPageCompleted();
//                }
            }
        }

        function x(x){
            console.log(x);
            return "lol"
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
                PropertyChanges { target: wizardStateView; currentView: x(parent.name); }
            }
        ]

        StackView {
            id: stackView
            initialItem: wizardStateView.wizardHomeView
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
	    
	}
}