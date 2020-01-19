import QtQuick 2.12
import QtQuick.Controls 2.12
import io.qt.genpass 1.0

Page {
    id: lessPass
    background: Rectangle {
        color: "transparent"
    }

    GenPass {
        id: genPass
    }

    Column {
        id: calPass
        spacing: 20
        anchors.centerIn: parent

        PassForm {
            id: easyPass
            icon: "qrc:/images/KeyC.png"
            word: "简易密码，最长16位..."
            modes: TextInput.PasswordEchoOnEdit
            pass: genPass.easyPass
            length: 16

            onTextChanged: {
                genPass.easyPass = pass
                genPass.genLess()

                txtInfo.text = qsTr("")
                //console.log(genPass.lessPass)
            }

            onBtnPressed: {
                easyPass.modes = TextInput.Normal
            }

            onBtnReleased: {
                easyPass.modes = TextInput.PasswordEchoOnEdit
            }
        }
        PassForm {
            id: signPass
            icon: "qrc:/images/LockC.png"
            word: "识别码，最长12位..."
            modes: TextInput.PasswordEchoOnEdit
            pass: genPass.saltPass
            length: 12

            onTextChanged: {
                genPass.saltPass = pass
                genPass.genLess()

                txtInfo.text = qsTr("")
                //console.log(genPass.lessPass)
            }

            onBtnPressed: {
                signPass.modes = TextInput.Normal
            }

            onBtnReleased: {
                signPass.modes = TextInput.PasswordEchoOnEdit
            }
        }
        PassForm {
            id: finalPass
            icon: "qrc:/images/Sign-Up-01C.png"
            word: "最终密码..."
            read: true
            pass: genPass.lessPass
            btnBg: Image {
                id: btnImg
                source: "qrc:/images/copy_01.png"
            }
            onBtnPressed: {
                btnImg.source = "qrc:/images/copy_02.png"
            }
            onBtnReleased: {
                btnImg.source = "qrc:/images/copy_01.png"
            }
            onBtnClicked: {
                formArea.selectAll()
                formArea.copy()

                txtInfo.text = qsTr("密码已复制到剪切板")
            }
        }
    }

    Label {
        id: txtInfo
        anchors.top: calPass.bottom
        anchors.topMargin: 13
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"

        FontLoader {
            id: fonts
            source: "qrc:/font/MFYueHei_Noncommercial-Regular.ttf"
        }
        font.family: fonts.name
        font.pixelSize: 16
    }
}
