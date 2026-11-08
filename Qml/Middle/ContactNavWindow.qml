import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//通信录
ColoredFrame{
    id: root
    color: "lightgray"
    padding: 0

    property alias index: stackLayout.currentIndex  //最下面的列表栈索引

    required property var currentFriend
    required property var currentGroup      //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态
    required property var currentDevice      //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态

    signal deviceSelected(var deviceData)           //选中设备的信号---参数为设备信息的json对象
    signal friendSelected(var friendData)           //选中分组中好友
    signal selectedGroup(var groupData)             //选中群Item的信号
    signal friendNoticeClicked()                    //点击了好友通知

    ColumnLayout{
        id: cl
        anchors.fill: parent
        spacing: 0

        //1. 好友通知
        MessageNoticeButton{
            id: btnFriendNotice
            Layout.fillWidth: true
            text: qsTr("Friend Notices")
            onClicked: {
                root.friendNoticeClicked()  //取消好友的选中状态---父组件完成
            }
        }

        //2. 群通知
        MessageNoticeButton{
            id: btnChatGroupNotice
            Layout.fillWidth: true
            text: qsTr("Chat Group Notices")

        }

        //3. 自定义TabBar: 分组/群/设备切换
        GroupTabBar{
            id: btnSwitch
            Layout.fillWidth: true

            currentIndex: root.index
            onItemSelected: (index)=>{
                                // console.log("Group switch selected index: " +index)
                                stackLayout.currentIndex=index
                            }
        }

        //4. StackLayout 好友分组/群/设备列表
        StackLayout{
            id: stackLayout
            Layout.fillWidth: true
            Layout.fillHeight: true

            //好友列表
            FriendList{
                width: parent.width
                height: parent.height
                index: 0
                currentFriend: root.currentFriend

                onFriendSelected: (data)=>{
                                      // console.log("ContactNavWindow handle frienditem click: ", JSON.stringify(data))
                                      root.friendSelected(data)
                                  }
            }

            //群列表
            GroupList{
                width: parent.width
                height: parent.height
                index: 1
                currentGroup: root.currentGroup
                //群item选中处理, 上报父组件
                onSelectedGroup: (data)=>root.selectedGroup(data)
            }

            //设备列表
            DeviceList{
                id: deviceList
                index: 2
                currentDevice: root.currentDevice
                onDeviceSelected: (data)=>{
                                      // console.log("ContactNavWindow handle selected device: "+JSON.stringify(data))
                                      root.deviceSelected(data)
                                  }
            }
        }


    }
}
