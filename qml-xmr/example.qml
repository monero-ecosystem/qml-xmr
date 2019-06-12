import QtQml 2.0
import QtQuick 2.9
import QtQuick.Window 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import moneroComponents.Wallet 1.0
import moneroComponents.NetworkType 1.0

ApplicationWindow {
    id: page
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    width: 320; height: 480
    color: "lightgray"

    Image {
        width: 128
        height: 128
        source: "qrc:///images/download-white.png"
    }

    Text {
        id: helloText
        text: "Hello world!"
        y: 30
        anchors.horizontalCenter: page.horizontalCenter
        font.pointSize: 24; font.bold: true
    }
}
