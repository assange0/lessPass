/**
* @brief 文本框界面
* @author Roger Aries
* @date 2017/08/01
*/

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

Rectangle {
    id: passForm
    implicitWidth: 330
    implicitHeight: 36
    border.color: "plum"
    border.width: 2
    radius: 18
    color: "transparent"

    property alias icon: icons.source
    property alias word: formInfo.placeholderText
    property alias pass: formInfo.text
    property alias modes: formInfo.echoMode
    property alias read: formInfo.readOnly
    property alias length: formInfo.maximumLength
    property alias formArea: formInfo

    signal textChanged
    signal btnPressed
    signal btnReleased
    signal btnClicked

    Image {
        id: icons
        width: parent.height
        height: width
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
    }

    TextField {
        id: formInfo
        anchors.left: icons.right
        anchors.right: btn.left
        anchors.leftMargin: 7
        anchors.rightMargin: 7
        color: "pink"

        FontLoader {
            id: fonts
            source: "qrc:/font/MFYueHei_Noncommercial-Regular.ttf"
        }

        font.family: fonts.name
        onTextChanged: {
            passForm.textChanged()
        }
    }

    RoundButton {
        id: btn
        width: parent.height
        height: width
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        highlighted: true
        Material.accent: Material.Red
        opacity: 0.7

        onPressed: {
            passForm.btnPressed()
        }

        onReleased: {
            passForm.btnReleased()
        }

        onClicked: {
            passForm.btnClicked()
        }
    }
}