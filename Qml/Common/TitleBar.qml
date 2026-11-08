import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: titleBar
    width: 400; height: 70
    color: "#F2F2F2"

    // 窗口拖动区域（仅空白处）
    MouseArea {
        anchors.fill: parent
        // onPressed: window.startSystemMove()
        onDoubleClicked: toggleMaximize() // 双击切换最大化
    }

    // 最大化/还原切换函数
    function toggleMaximize() {
        if (maximized === true) {
            showNormal()
            maximized = false
        } else {
            showMaximized()
            maximized = true
        }
        //playWindowEffect()
    }

    //纵向布局: 1. 上面为title: 最大/最小/关闭按钮; 2. 下面为stack区域, 为快捷操作按钮
    Column{
        anchors.fill: parent

        //上面的可拖动/最大最小/关闭等工具条
        Rectangle{
            id: title
            width: parent.width
            height: 30
            color: "transparent" //"yellow" //for test

            Row {
                height: 28  //工具条固定高度
                // width: parent.width  //不用沾满宽度, 否则几个按钮都是在左边
                anchors {
                    top: title.top
                    right: title.right
                }
                spacing: 5

                //最小化按钮
                SystemButton {
                    id: minButton
                    height: parent.height
                    width:height*1.5
                    text: "🗕"
                    onClicked: showMinimized() //window.showMinimized()
                    background: Rectangle {
                        color: {
                            if (minButton.hovered) {
                                return "lightgray"
                            }
                            return "transparent"
                        }
                    }
                    // Component.onCompleted: agent.setSystemButton(WindowAgent.Minimize, minButton)
                }

                //最大化按钮
                SystemButton {
                    id: maxButton
                    height: parent.height
                    width:height*1.5
                    text: maximized === true ? "🗗" : "🗖"
                    onClicked: {
                        if (maximized === true) {
                            showNormal()
                            maximized = false
                        } else {
                            showMaximized()
                            maximized = true
                        }
                    }
                    background: Rectangle {
                        color: {
                            if (maxButton.hovered) {
                                return "lightgray"
                            }
                            return "transparent"
                        }
                    }
                    // Component.onCompleted: agent.setSystemButton(WindowAgent.Maximize, maxButton)
                }

                //关闭按钮
                SystemButton {
                    id: closeButton
                    height: parent.height
                    width:height*1.5
                    text: "🗙"
                    background: Rectangle {
                        color: {
                            if (!closeButton.enabled) {
                                return "lightgray"
                            }
                            if (closeButton.hovered) {
                                return "#e81123"
                            }
                            return "transparent"
                        }
                    }
                    onClicked: close()   //关闭窗口
                    // Component.onCompleted: agent.setSystemButton(WindowAgent.Close, closeButton)    //window的关闭与此按钮关联
                }
            }
        }

        //下面为某个子窗口 工具条栈: 1. 聊天窗口: 显示呼叫/好友信息等按钮
        Rectangle{
            id: subTitle
            width: parent.width
            Layout.fillHeight: true
            // color: "lightgray"   //for test
            color: "transparent"
            Text {
                id: name
                anchors.centerIn: parent
                // text: qsTr("sub title")
            }
        }
    }

}
