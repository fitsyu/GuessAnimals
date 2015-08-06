import QtQuick 2.2
import QtQuick.Window 2.2

Window {
    width: Qt.platform.os==="android"?Screen.width:960
    height: Qt.platform.os==="android"?Screen.height:540
    title: qsTr("Nebak Binatang")
    visible: true

    visibility: Qt.platform.os==="android"?"FullScreen":"Windowed"

    TestScreen {
        id: m_test; visible: false
        onMenuPlease: m_menu.visible = true
        onVisibleChanged: {
            if (visible) {
                m_test.fillQuestionTanks()
            }
        }
        onTanks_filled: nextQuestion()
    }

    InfoScreen {
        id: m_info; visible: false;
        onMenuPlease: m_menu.visible = true
    }

    AnimalsScreen {
        id: m_animals; visible: false;
        onMenuPlease: m_menu.visible = true
    }

    MenuScreen {
        id: m_menu
        onTestPlease: {
//            emitter.burst(1000, m_test.x, m_test.y)
            m_test.visible = true
        }
        onInfoPlease: {

            m_info.visible = true
        }
        onLearnPlease: { m_animals.visible = true }
    }

    StarEmitter {id: emitter}
    SplashScreen {
        onVisibleChanged: {
            if (visible === false)
                emitter.pulse(2000)
        }
    }
}
