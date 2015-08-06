import QtQuick 2.0

Rectangle {
    width: 100
    height: 62

    color: "black"
    opacity: 0.85
    border.color: "white"
    radius: 15
    border.width: 6

    signal cliked

    property alias text: label.text

    Text {
        id: label
        anchors.centerIn: parent
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            cliked()
        }

        onPressed: parent.border.color = "red"
        onReleased: parent.border.color = "white"
    }
}
