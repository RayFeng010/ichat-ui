import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//群列表
ColoredFrame{
    id: root
    color: "transparent"  //color: "lightgray" //for test
    padding: 0
    width: 150; height: 300

    property int index: -1  //在StackLayout中的当前索引

    ChatMessagesModel{id: chatMessagesModel}              //聊天消息 mode 数据

    // 新增当前选中设备
    required property var currentChatNav //聊天消息选中

    signal chatNavSelected(var chatNavCode)           //选中聊天导航的信号---参数为设备信息的json对象

    //设置背景色
    // Rectangle{
    //     anchors.fill: parent
    //     color: "yellow"    // "lightgray" for test
    // }
    //1. ListView 整体列表
    ListView{
        id: listView
        currentIndex: -1
        anchors.fill: parent
        anchors.topMargin: 8

        // 注: 不能在顶层ListView中设置margin, 因为 好友item需要贯穿整行的hover效果
        // anchors.leftMargin: 12
        // anchors.rightMargin: 12

        clip: true  //防止内容溢出

        model: chatMessagesModel             //独立的model文件
        delegate: ChatNavDelegate{       //独立的UI展示 delegate
            // 显式传递模型上下文
            // model: modelData  // 传递过滤后的数据项

            //传入当前是否选中的参数
            currentChatNav: root.currentChatNav

            //某个设备被选中事件处理, 子组件中clicked函数传入device信息, 通过json对象传参
            onClicked: (data)=>{
                           console.log("ChatNavList onClicked: ", JSON.stringify(data))
                           listView.currentIndex = data.index
                           root.chatNavSelected(data)
                       }
        }
    }
}

