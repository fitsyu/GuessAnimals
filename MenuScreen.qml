import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1

Rectangle {
    width: 960
    height: 540
    color: "lightblue"
    anchors.fill: parent
    id: menuWindow

    signal testPlease()
    signal learnPlease()
    signal infoPlease()

    Image {
        id: background
        source: "/img/forest.jpg"
        anchors.fill: parent
    }
    ButtonX {
        id: btTes
        x: 501
        y: 98
        width: 172
        height: 137
        text: qsTr("Tes")
        onCliked: {
            //            emitter.pulse(1000)
            testPlease()
            menuWindow.visible = false
        }
    }

    ButtonX {
        id: btDaftarHewan
        x: 295
        y: 98
        width: 172
        height: 137
        text: qsTr("Belajar")
        onCliked:
        {
            learnPlease()
            menuWindow.visible = false
        }
    }

    ButtonX {
        id: btInfo
        x: 295
        y: 277
        width: 172
        height: 137
        text: qsTr("Informasi")
        onCliked:{
            infoPlease()
            menuWindow.visible = false
        }
    }

    ButtonX {
        id: btKeluar
        x: 502
        y: 277
        width: 171
        height: 140
        text: qsTr("Exit")
        onCliked: {
            // TODO : confirmation dialog
            Qt.quit()
        }
    }
}
