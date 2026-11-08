import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import RelaxControls 1.0

Rectangle {
    id: root

    color: "white"  //"yellow" for test

    //数据模型
    property alias stackIndex: stack.currentIndex

    required property var currentFriend
    required property var currentGroup      //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态
    required property var currentDevice       //当前选中的聊天Nav item--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态
    required property var currentChatNav       //当前选中的聊天Nav item--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态

    signal deviceSelected(var deviceData)           //选中设备的信号---参数为设备信息的json对象
    signal friendSelected(var friendData)           //好友分组中的item被选中
    signal selectedGroup(var groupData)             //选中群Item的信号
    signal friendNoticeClicked()                    //点击了好友通知
    signal chatNavSelected(var chatNavCode)           //选中聊天导航的信号---参数为设备信息的json对象

    Column{
        anchors.fill: parent
        // anchors.leftMargin: 1
        // anchors.rightMargin: 1

        //按住鼠标可拖动窗口的搜索框
        SearchBar{
            id: searchBar
            width: parent.width
        }

        //栈窗口: 通信录列表, 聊天列表
        StackLayout {
            id: stack
            width: parent.width
            height: parent.height - searchBar.height

            //通信录
            ContactNavWindow{
                id: contactNavWindow
                index: 0            //好友/群/设备 Stacklayout切换, 默认好友分组
                color: "white"  // "yellow" //for test
                currentFriend: root.currentFriend
                currentGroup: root.currentGroup
                currentDevice: root.currentDevice

                onFriendNoticeClicked: root.friendNoticeClicked()
                onDeviceSelected: (data)=>{
                                      // console.log("MiddleNavWindow handle selected device: "+JSON.stringify(data))
                                      root.deviceSelected(data)
                                  }

                onFriendSelected: (data)=>{
                                      // console.log("MiddleNavWindow handle frienditem click: ", JSON.stringify(data))
                                      root.friendSelected(data)
                                  }

                //群item选中处理, 上报父组件
                onSelectedGroup: (data)=>root.selectedGroup(data)
            }

            //聊天导航
            ChatNavWindow{
                id: chatNavWindow
                index: 0                //默认就是聊天导航list
                color: "white"
                currentChatNav: root.currentChatNav
                onChatNavSelected: (data)=>root.chatNavSelected(data)

            }

            //呼叫
            ColoredFrame{
                id: callPage
                color: "white"
                ColumnLayout{
                    width: parent.width
                    height: parent.height
                    Label {
                        text: "Call your friens Page"
                        color: "blue"

                    }

                    MyItemControls{
                        width: 100
                        height: 100

                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }

            }

            //设置
            ColoredFrame{
                id: settinsPage
                color: "white"
                Label {
                    anchors.centerIn: parent
                    text: "System setting page"
                }
            }
        }
    }
    // Component.onCompleted: {
    //     console.log("Middle window width: "+ root.width + ", height: "+ root.height)
    // }
}
