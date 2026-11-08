import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    color: "#F2F2F2"

    property alias stackIndex: stack.currentIndex

    required property var userInfo          //父组件传入用户数据
    required property var currentDevice     //父组件传入当前选中的设备
    required property var currentFriend     //父组件传入当前选中的好友
    required property var currentGroup      //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态
    required property var currentChatNav       //选中的聊天导航 Code

    //纵向布局:  1.上面窗口标题栏: 最小化/最大化/关闭 按钮
    //          2. 拖动移动窗口，双击可以做大化窗口
    //不能使用ColumnLayout，会屏蔽工具条的鼠标功能
    Column{
        anchors.fill: parent
        TitleBar{
            id: titleBar
            // color: "transparent"
            width: parent.width
        }

        //右侧内容区域: 设备信息/好友信息//群信息/聊天
        StackLayout{
            id: stack
            width: parent.width
            height: parent.height - titleBar.height

            //0: 未选中任何功能, 空页面
            ColoredFrame{
                id: msgPage
                color: "transparent"
                Image {
                    anchors.centerIn: parent
                    source: "images/ufo.png"
                }
            }

            //1: 设备信息
            DeviceInfoPage{
                // anchors.centerIn: parent
                index: 1
                // currentDevice: root.currentDevice
                deviceName: currentDevice===null?"":currentDevice.name
                os: currentDevice===null?"":currentDevice.os
                // HeaderImage: currentDevice.header
                cpuCores:  currentDevice===null?"":currentDevice.cpu
                memory:  currentDevice===null?"":currentDevice.memory
                hardDisk:  currentDevice===null?"":currentDevice.harddisk
                display:  currentDevice===null?"":currentDevice.display
                online:  currentDevice===null?"":currentDevice.online

            }

            //2: 好友详细信息
            FriendInfoPage{
                // anchors.centerIn: parent
                index: 2
                header: currentFriend===null?"":currentFriend.header        // "images/little_boy_1.png"
                online:  currentFriend===null?"":currentFriend.online       //true
                userName:  currentFriend===null?"":currentFriend.userName   //"陈代兵"
                code:  currentFriend===null?"":currentFriend.code           //true
                nickName:  currentFriend===null?"":currentFriend.nickName   //"CDB"
                gender:  currentFriend===null?"":currentFriend.gender       //"男"
                birthday: currentFriend===null?"":currentFriend.birthday    //2001-10-11
                city: currentFriend===null?"":currentFriend.city            //shenzhen China
                signature:  currentFriend===null?"":currentFriend.signature //"成都好安逸"
                remark:  currentFriend===null?"":currentFriend.remark       //"高中同学同桌"
            }

            //3: 群详细信息
            GroupInfoPage{
                // anchors.centerIn: parent
                index: 3
                width: root.width
                header: currentGroup===null?"":currentGroup.header        // "images/little_boy_1.png"
                groupName: currentGroup===null?"":currentGroup.name //"魔兽"
                code: currentGroup===null?"":currentGroup.code //"10011"
                owner: currentGroup===null?"":currentGroup.owner //"魔兽"
                remark: currentGroup===null?"":currentGroup.remark//"疯狂的年代"
                nickName: currentGroup===null?"":currentGroup.nickName //"Legolas"
                description: currentGroup===null?"":currentGroup.description //"那些年玩过的经典"
                bulletin: currentGroup===null?"":currentGroup.bulletin //"本周末聚餐"
                category: currentGroup===null?-1:currentGroup.category //"我创建的群"

            }

            //4. 好友邀请的通知信息
            FriendNoticeList{
                index: 4
            }

            //5. 聊天窗口
            ChatMessageWindow{
                id: chatMessageWindow
                width: root.width
                Layout.fillHeight: true
                Layout.fillWidth: true
                userInfo: root.userInfo
                currentChatNav: root.currentChatNav
                index: 5
            }

            Page{
                id: devicePage
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Device info Page")
                }
            }
            Page{
                id: friendDetailPage
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Friend Detail info Page")
                }
            }
            Page{
                id: chatPage
                Text {
                     anchors.centerIn: parent
                    text: qsTr("Chat Page")
                }
            }
        }
    }

    // Component.onCompleted: {
    //     console.log("Right content window init width: "+root.width)
    // }
}
