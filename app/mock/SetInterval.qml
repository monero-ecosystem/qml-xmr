import QtQuick 2.7; import QtQuick.Layouts 1.2; import QtQuick.Controls 2.0; Timer { interval: 100; running: true; repeat: true; signal onTriggeredState; onTriggered: onTriggeredState(); }
