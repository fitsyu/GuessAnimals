import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    width: 100
    height: 62
    anchors.fill: parent

    id: rootRect

    signal menuPlease()

    Image {
        id: background
        source: "/img/sky.jpg"
        anchors.fill: parent
    }

    Label {
        anchors.centerIn: parent
        text: "Dibuat untuk menunaikan tugas IMK\n"+
              "yang diberikan oleh ibu Atika Laras Paramita\n"+
              "Programming  :  FITSYU" + "\n"+
              "Data         :  KOMO DANANG ANI" + "\n"

        color: "white"
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            rootRect.visible = false
            menuPlease()
        }
    }
}
