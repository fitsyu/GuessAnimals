import QtQuick 2.0

Rectangle {
    id: buttonRect
    property string answerText : "Jawaban";
    signal choosen()

    Text {
        anchors.centerIn: parent
        text: answerText
        color: "white"
    }

    width: 150
    height: 62

    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#1baecf";
        }
        GradientStop {
            position: 1.00;
            color: "#000000";
        }
    }

    border.color: "black"
    border.width: 5
    radius: 10

    MouseArea {
        anchors.fill: parent
        onClicked: {
            toet.start()
            choosen()
        }
    }

    Behavior on answerText {
        PropertyAnimation {
            target: buttonRect
            property: "y"
            from: y+50
            to: y
            onStarted: buttonRect.enabled = false
            onStopped: buttonRect.enabled = true
        }
    }

    SequentialAnimation {
        id: toet
        PropertyAnimation {
            target: buttonRect
            property: "scale"
            to: 0.8
        }
        PropertyAnimation {
            target: buttonRect
            property: "scale"
            to: 1
        }
    }
}
