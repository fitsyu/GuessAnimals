import QtQuick 2.0

Rectangle {
    width: 100
    height: 62
    anchors.fill: parent
    color: "lightblue"

    id: rootRect


    Image {
        width: parent.width
        height: parent.height
        source: "/img/zoo-india.jpg"
    }

    MouseArea {
        onClicked: rootRect.visible = false
        anchors.fill: parent
    }
}
