import QtQuick 2.0
import QtQuick.Controls 1.2
import QtMultimedia 5.0

Rectangle {
    width: 960
    height: 540
    id: myRootWindow

    property int animal_index


    AnimalsModel { id: animals }

    ListElement { id: currentAnimal }

    Image {
        width: parent.width
        height: parent.height
        source: "/img/forest.jpg"
        anchors.centerIn: parent
    }

    onVisibleChanged: {
        if (visible)
            animal_sound.play()
    }


    Row {
        anchors.centerIn: parent
        spacing: 30
        Image {
            source:  animals.get(animal_index).portrait
            width: 200; height: 300;
        }

        Flickable {
            width: 400
            height: 300
            contentHeight: 800
            Rectangle {
                width: 400
                height: label.text.length  // * 2

                color: "black"
                opacity: 0.5
                Label {
                    id: label
                    anchors.topMargin: 15
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "<br>"+
                          "<b>Nama    :</b> " + animals.get(animal_index).name + "<br>"+
                          "<b>Habitat :</b> " + animals.get(animal_index).habitat + "<br>"+
                          "<br>" + animals.get(animal_index).description
                    wrapMode: Text.Wrap
                    width: 300
                    horizontalAlignment: Text.AlignJustify
                    color: "white"
                }
            }
        }
    }


    Audio {
        id: animal_sound
        source: animals.get(animal_index).sound
    }

    Rectangle {
        anchors.top: parent.top
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
            source: "/img/animals-grid.png"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                myRootWindow.visible = false;
            }
        }

    }
}

