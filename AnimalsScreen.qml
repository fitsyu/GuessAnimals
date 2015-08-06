import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle
{
    width: 960
    height: 540

    id: rootWindow

    signal menuPlease()



    function showDetail(index){
        detail_screen.visible = true
        detail_screen.animal_index = index
    }

    Image {
        width: parent.width
        height: parent.height
        source: "/img/forest.jpg"
        anchors.centerIn: parent
    }

    GridView {
        id: table
        anchors.centerIn: parent
        model: AnimalsModel {}
        width: parent.width - 25
        height: parent.height -25
        focus: true
        delegate:
            Rectangle {
            width: 80; height: 80
            color: "lightsteelblue"
            radius: 10
            border.color: "black"
            border.width: 3
            opacity: 0.85

            Column {
                anchors.centerIn: parent
                spacing: 2
                Image {
                    width: 50; height: 50
                    source: portrait
                    opacity: 1
                }
                Label {
                    horizontalAlignment: Text.AlignHCenter
                    text: name
                    color: "black"
                    wrapMode: Text.Wrap
                }

            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    showDetail(index)
                    table.currentIndex = index
                }
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width: 100
        height: 100
        color: "black"
        border.color: "white"
        opacity: 0.8
        radius: 10
        Image {
            anchors.centerIn: parent
            width: parent.width / 3
            height: width
            source: "/img/menu.png"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                menuPlease()
                rootWindow.visible = false
            }
        }
    }

    AnimalDetailsScreen { id: detail_screen; visible: false; anchors.fill: parent }


}
