import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//通信录
ColoredFrame{
    id: root
    color: "lightgray"
    padding: 0

    ColumnLayout{
        id: cl
        anchors.fill: parent
        spacing: 0

        // 顶部可折叠区域
        Rectangle {
            id: header
            property bool collapsed: false // 必须在此处声明
            Layout.fillWidth: true
            height: collapsed ? 0 : 70
            clip: true
            color: "transparent"

            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                //1. 好友通知
                MessageNoticeButton{
                    id: btnFriendNotice
                    Layout.fillWidth: true
                    text: qsTr("Friend Notices")
                }


                //2. 群通知
                MessageNoticeButton{
                    id: btnChatGroupNotice
                    Layout.fillWidth: true
                    text: qsTr("Chat Group Notices")
                }
            }
        }

        //好友分组/群列表
        FriendGroupList{
            // Layout.preferredHeight: root.height - header.height  // 动态计算高度
            height: root.height - header.height  // 动态计算高度
            Layout.fillWidth: true
            Layout.fillHeight: true

            scrollThreshold: 60  // 自定义滚动阈值

            onScrollDirectionChanged: (scrollingUp) => {
                                          header.collapsed = scrollingUp && (contentY > 0)
                                      }
        }

        // Item {
        //     id: spacer
        //     Layout.fillHeight: true
        // }
    }
}
