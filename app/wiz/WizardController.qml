import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import "../js/Windows.js" as Windows
import "../js/Utils.js" as Utils
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
        // Layout.preferredWidth: wizardController.width
        // Layout.preferredHeight: wizardController.height
        color: "transparent"
        state: "Home"

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

        states: [
            State {
                name: "Language"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardLanguageView }
            }, State {
                name: "Home"
                PropertyChanges { target: wizardStateView; currentView: wizardStateView.wizardHomeView }
            }
        ]

        StackView {
            id: stackView
            initialItem: wizardStateView.wizardLanguageView
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