import QtQuick 2.7
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: mainWindow
    width: 650
    height: 490
    color: "transparent"
    flags: Qt.FramelessWindowHint | Qt.Window
    visible: true

    // 这个rectangle放在最下面，方便加上外发光效果
    Rectangle {
        id: containers
        width: 640
        height: 480
        radius: 7
        anchors.centerIn: parent

        // 无边框时用鼠标拖曳
        MouseArea {
            id: dragRegion
            anchors.fill: parent
            property point clickPos: "0,0"
            onPressed: {
                clickPos = Qt.point(mouse.x, mouse.y)
            }
            onPositionChanged: {
                // 鼠标偏移量
                var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)

                // 如果mainwindow继承自QWidget,用setPos
                mainWindow.setX(mainWindow.x + delta.x)
                mainWindow.setY(mainWindow.y + delta.y)
            }
        }

        // 主要操作界面
        Rectangle {
            id: pageView
            width: parent.width
            height: 426
            radius: 7

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: bgs
                anchors.fill: parent
                source: "qrc:/images/bgs.png"

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: bgs.width
                        height: bgs.height
                        Rectangle {
                            anchors.centerIn: parent
                            width: bgs.width
                            height: bgs.height
                            radius: 6
                        }
                    }
                }

                CreatePass {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: -15
                }
            }
        }

        // 顶部标题
        Label {
            id: passLabel
            width: parent.width
            height: 60
            wrapMode: Label.Wrap
            horizontalAlignment: Qt.AlignHCenter
            background: Rectangle {
                color: "black"
            }
            FontLoader {
                id: fonts
                source: "qrc:/font/MFYueHei_Noncommercial-Regular.ttf"
            }
            Text {
                text: "密码生成器"
                anchors.centerIn: parent
                font.family: fonts.name
                font.pixelSize: 36
                color: "papayawhip"
            }
        }

        // 自定义退出按钮
        Rectangle {
            id: quitArea
            anchors.right: parent.right
            anchors.top: parent.top
            width: 36
            height: 36
            radius: 6
            color: "transparent"

            Image {
                anchors.fill: parent
                id: quitIcon
                source: "qrc:/images/quitIcon.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: quitArea.color = "#80CD2990"
                    onExited: quitArea.color = "transparent"
                    onClicked: Qt.quit()
                }
            }
        }

        // 自定义最小化按钮
        Rectangle {
            id: closeArea
            anchors.right: quitArea.left
            anchors.top: parent.top
            width: 36
            height: 36
            radius: 6
            color: "transparent"

            Image {
                anchors.fill: parent
                id: closeIcon
                source: "qrc:/images/minus.png"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: closeArea.color = "#80CD2990"
                    onExited: closeArea.color = "transparent"
                    onClicked: {
                        mainWindow.showMinimized()
                    }
                }
            }
        }
    }

    // 底部加上外发光
    Glow {
        anchors.fill: containers
        radius: 8
        samples: 17
        color: "darkslategray"
        source: containers
        transparentBorder: true
    }
}
