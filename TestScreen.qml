import QtQuick 2.0
import QtQuick.Controls 1.2


Rectangle {
    width: 960
    height: 540
    ////    anchors.fill: parent
    color: "#443737"
    ////    visible: true

    // init
    onVisibleChanged: {
        if (visible){
            resetTes()
        }
    }

    id: rootWindow

    signal menuPlease()

    property string right_answer;
    property int jumlah_soal: 10;
    property int jawaban_benar;
    property int jawaban_salah;
    property int hint_shown;
    property real nilai;


    AnimalsModel { id: animals }

    Image {
        width: parent.width
        height: parent.height
        source: "/img/deep-sea.jpg"
    }

    Rectangle {
        width: 500
        height: 250
        color: "black"
        opacity: 0.8
        border.color: "black"
        radius: 25
        anchors.centerIn: parent
        Image {
            id: image1
            anchors.centerIn: parent
            width: 437
            height: 232
            //            source: "" // generated

            Behavior on source {
                ParallelAnimation {
                    PropertyAnimation {
                        target: image1
                        property: "rotation"
                        easing.type: Easing.InQuad
                        from: 190
                        to: 0
                        duration: 500
                    }
                    PropertyAnimation {
                        target: image1
                        property: "scale"
                        easing.type: Easing.InQuad
                        from: 3
                        to: 1
                        duration: 500
                    }

                    PropertyAnimation {
                        target: image1
                        property: "opacity"
                        easing.type: Easing.InQuad
                        from: 0
                        to: 1
                        duration: 500
                    }
                }
            }
        }


    }

    Row {
        //        rows: 2
        //        columns: 2
        spacing: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        AnswerButton {
            id: jawabanA
            answerText: qsTr("Jawaban A")
            onChoosen: answer(1)
        }

        AnswerButton {
            id: jawabanB
            answerText: qsTr("Jawaban B")
            onChoosen: answer(2)
        }

        AnswerButton {
            id: jawabanC
            answerText: qsTr("Jawaban C")
            onChoosen: answer(3)
        }

        AnswerButton {
            id: jawabanD
            answerText: qsTr("Jawaban D")
            onChoosen: answer(4)
        }

    }

    Hint {
        id: hint1
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        width: 54
        height: 54
        tipe: 0
        onRevealed: hint_shown++
    }

    ProgressBar {
        id: progress_bar
        width: rootWindow.width / 3
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        minimumValue: 1
        maximumValue: jumlah_soal + 1

        Behavior on value {
            NumberAnimation {}
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

    Rectangle {
        id: check_status
        width: parent.width
        height: parent.height
        color: "transparent"

        property int status:1;

        Image {
            id: status_image
            width: parent.width / 4
            height: parent.height / 3
            anchors.centerIn: parent
            source: "/img/correct.png"
        }

        onStatusChanged: {
            status_image.source = status===1?"/img/correct.png":"/img/wrong.png"
        }

        opacity: 0
        Timer {
            id: timer
            interval: 500
            onTriggered:  check_status.opacity = 0
        }

        function show()
        {
            opacity = 1;
            timer.start()
        }
    }

    Rectangle {
        id: hasil_tes
        width: parent.width / 2
        height: parent.height / 2
        anchors.centerIn: parent
        visible: false
        color: "steelblue"
        border.color: "white"
        radius: 20

        onVisibleChanged: {
            if (visible) {
                nilai = Math.round( (jawaban_benar / jumlah_soal) * 100 ) - hint_shown*10;
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 15

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                width: hasil_tes.width / 2
                height: hasil_tes.height / 2
                color: "black"
                border.color: "white"
                opacity: 0.8
                radius: 10
                Label {
                    anchors.centerIn: parent
                    color: "white"
                    text: "Hasil Tes \n\n" +
                          "Benar       : "+ jawaban_benar + "\n" +
                          "Salah       : "+ jawaban_salah + "\n" +
                          "Jumlah soal : "+ jumlah_soal + "\n" +
                          "Hint        : "+ hint_shown + "\n" +
                          "\n" +
                          "NILAI       :  "+ nilai
                    font.bold: true
                }
            }



            Row {
                spacing: 10
                Button {
                    id: btLagi
                    width: (hasil_tes.width /2) - 5
                    height: width/3
                    text: "Lagi lagi"
                    onClicked: {
                        resetTes()
                        hasil_tes.visible = false
                        fillQuestionTanks()
                    }

//                    style: ButtonStyle {
//                        background: Rectangle { color: "black" }
//                        label: Text { color: "white"; text: btLagi.text }
//                    }
                }
                Button {
                    id: btOK
                    width: (hasil_tes.width /2) - 5
                    height: width/3
                    text: "Udah ah"
                    onClicked: {
                        resetTes()
                        hasil_tes.visible = false
                        menuPlease()
                    }
                }
            }
        }
        Behavior on visible {
            RotationAnimation {
                target: hasil_tes
                property: "rotation"
                from: 0
                to: 360
                duration: 1000
            }
        }
    }


    Timer {
        id: delayQuestion
        onTriggered: nextQuestion()
    }

    StarEmitter { id: tes_emitter }
    Timer {
        id: delayResult
        onTriggered: {
            tes_emitter.pulse(500)
            hasil_tes.visible = true
        }
    }

    signal tanks_filled()
    property var question_tanks: []
    function fillQuestionTanks(){
        //        // preparation
        question_tanks = []
        for (var c=0; c<animals.count; c++){
            question_tanks.push(c)
        }

        // take them one by one
        var elected_index;
        for (var e=0; e< (animals.count-jumlah_soal); e++){
            elected_index = parseInt(0 + Math.floor(Math.random() * question_tanks.length));
            question_tanks.splice(elected_index, 1);
        }

        // done
//        console.log(question_tanks)
        tanks_filled()
    }


    function nextQuestion(){
        var question_index = question_tanks.shift()

        image1.source = animals.get(question_index).portrait;
        hint1.secret = animals.get(question_index).sound;

        right_answer = animals.get(question_index).name;

        var wrong_answers = []
        var wrong_index;
        var i=0
        while (i<3 ){
            wrong_index = parseInt( Math.floor(Math.random() * animals.count-1) + 1 )
            if ( wrong_answers.indexOf(wrong_index) === -1
                    && wrong_index != question_index){
                wrong_answers.push(wrong_index);
                i++;
            }
        }

        // positioning
        var all_answers = []
        all_answers = wrong_answers.concat(question_index);

        var right_answer_place = parseInt( Math.floor(Math.random() * 3) + 1 );

        // switch place
        var tmp;
        for (var a=0; a<all_answers.length; a++){
            if (parseInt(a) === right_answer_place )
            {
                tmp = all_answers[a]
                all_answers[a] = question_index;
                all_answers[all_answers.length-1] = tmp
            }
        }

        jawabanA.answerText = animals.get( all_answers[0] ).name
        jawabanB.answerText = animals.get( all_answers[1] ).name
        jawabanC.answerText = animals.get( all_answers[2] ).name
        jawabanD.answerText = animals.get( all_answers[3] ).name
    }

    function checkAnswer(herAnswer){
        if (right_answer === herAnswer){
            jawaban_benar++;
            check_status.status = 1;
        }
        else{
            jawaban_salah++;
            check_status.status = 0;
        }
        check_status.show()
    }

    function answer(choice){
        switch (choice){
        case 1:
            checkAnswer(jawabanA.answerText)
            break;
        case 2:
            checkAnswer(jawabanB.answerText)
            break;
        case 3:
            checkAnswer(jawabanC.answerText)
            break;
        case 4:
            checkAnswer(jawabanD.answerText)
            break;
        }

        progress_bar.value = progress_bar.value + 1;
        if ( progress_bar.value < jumlah_soal ){
            delayQuestion.start()
        } else {
            delayResult.start()
        }
    }

    function resetTes() {
        jawaban_benar = 0;
        jawaban_salah = 0;
        nilai = 0;
        hint_shown = 0;
        progress_bar.value = 0;
    }
}
