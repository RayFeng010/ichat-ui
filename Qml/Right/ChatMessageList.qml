import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//群列表tNavCode)           //选中聊天导航的信号---参数为设备信息的json对象

//1. ListView 整体列表
ListView{
    id: chatListPage
    spacing: 5
    currentIndex: -1
    anchors.right: parent.right
    anchors.left: parent.left
    cacheBuffer: 2000  // 预加载额外 2000px 区域（根据需求调整）

    property int index: -1  //在StackLayout中的当前索引

    required property var userInfo              //父组件传入用户数据
    required property var currentChatNav        //设备在线状态

    required property var messageModel          //消息列表

    // 注: 不能在顶层ListView中设置margin, 因为 好友item需要贯穿整行的hover效果
    // anchors.leftMargin: 12
    // anchors.rightMargin: 12


    clip: true  //防止内容溢出

   // model: chatListPage.getMessageModel()        //根据当前选中的ChatNav 获取消息model
    model: messageModel
    delegate: ChatMessageDelegate{       //独立的UI展示 delegate
        //父组件参数
        userInfo: chatListPage.userInfo
        currentChatNav: chatListPage.currentChatNav

        //某个设备被选中事件处理, 子组件中clicked函数传入device信息, 通过json对象传参
        // onClicked: (data)=>{
        //                console.log("ChatNavList onClicked: ", JSON.stringify(data))
        //                listView.currentIndex = data.index
        //                root.chatNavSelected(data)
        //            }
    }

    onCountChanged: {
        chatListPage.positionViewAtEnd();
        moveEndPosTime.restart();
    }

    // ScrollBar.vertical: ScrollBar {
    //     id: bar
    //    policy: size<1.0? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
    // }


    //垂直滚动条
    // ScrollBar.vertical: ScrollBar {
    //     id: bar
    //     stepSize: 100
    //     anchors.right: parent.right-2
    //     height: parent.height
    //     width: 5
    //     active: true
    // }

    Component.onCompleted: {
        console.log("ChatMessageList initiate width: "+root.width)
    }

    Timer {
        id: moveEndPosTime
        interval: 300
        onTriggered: {
            chatListPage.positionViewAtEnd();
        }
    }
}


