/*
 * this component when activated
 * reveal something
 * that can be either one of:
 * 1. image
 * 2. sound
 * 3.
 * 4.
 * as a clue for current animal in question
 */
import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
    width: 100
    height: 100
    color: "black"
    border.color: "white"
    border.width: 2
    radius: 50
    id: hintRect

    signal revealed()
    property string secret;
    property int  tipe: 0 // stands for undefined tipe. set to [1|2|3|4]

    property int validTipe; //: [0,1,2,3,4]
    onTipeChanged: {
        // change according to choosen tipe
        if ( [0,1,2,3,4].indexOf(tipe) == -1 ){
            console.log("tipe tidak valid. tipe yang valid: 0, 1, 2, 3, 4")
        }
    }

    Image {
        anchors.centerIn: parent
        width: parent.width /2
        height: width
        source: "/img/sound.png"
    }

    Audio {
        id: secret_audio
        source: secret
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        onClicked: {
            if (tipe === 0) // sound
            {
                console.log("revealing secret..")
                revealed()
                secret_audio.play()
                toet.start()
            }
        }

    }

    SequentialAnimation {
        id: toet
        PropertyAnimation {
            target: hintRect
            property: "scale"
            to: 3
        }
        PropertyAnimation {
            target: hintRect
            property: "scale"
            to: 1
        }
    }
}


