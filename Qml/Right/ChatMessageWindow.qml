import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//上线切分窗口： 1. 上面聊天消息列表; 2. 下面是聊天输入窗口
SplitView{
    id: root
    orientation: Qt.Vertical
    spacing: 0
    // SplitView.fillHeight: true
    // SplitView.fillWidth: true

    property int index: -1
    property var userInfo: null                 //父组件传入用户数据

    required property var currentChatNav       //选中的聊天导航 Coe


    ChatMessagesModel{ id: chatMessagesModel }              //聊天消息 mode 数据

    //聊天消息model
    // property var messagesModel: null

    function getMessageModel(){
        if(currentChatNav === null || userInfo === null)
            return null

        const chatNavCount=chatMessagesModel.count
        for(var i=0; i < chatNavCount; i++){
            var chatNav=chatMessagesModel.get(i)
            if(chatNav.code === currentChatNav.code){
                console.log("messages model found, friend code: " + currentChatNav.code + ", message count: " + chatNav.messages.count)
                return chatNav.messages
            }

        }
        return null
    }


    //splitView分割线自定义样式
    handle: Rectangle {
        id: handleDelegate
        implicitHeight: 2           //横向分隔条

        //分隔条hover样式
        color: SplitHandle.pressed ? "#E9E9E9"
                                   : (SplitHandle.hovered ? Qt.lighter("#E9E9E9", 0.8) : "#E9E9E9")
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.SizeVerCursor // 设置自定义光标（横向分割条）
        }
    }

    //上面消息列表
    ChatMessageList{
        id: messageListWindow
        height: parent.height-inputWindow.height
        width: root.width
        SplitView.fillWidth: true
        SplitView.fillHeight: true
        SplitView.minimumHeight: 300 // 可选：设置最小高度避免被压缩消失
        // color: "green"

        userInfo: root.userInfo
        currentChatNav: root.currentChatNav
        messageModel: getMessageModel()
    }

    //下面内容消息输入
    ChatMessageInput{
        id: inputWindow
        SplitView.preferredHeight: 180   //初始化宽度220
        SplitView.minimumHeight: 100
        SplitView.maximumWidth: 450      //最宽350px
        // Layout.fillWidth: true
        Layout.alignment: Qt.AlignBottom // 确保底部对齐

        onSendTextMessage: (textMessage) => {
                               //发送了文本消息, for test向本地model中添加文本消息
                               console.log("ChatMessageWindow onSendTextMessage")

                               var msgModel = getMessageModel()
                               msgModel.append({"senderCode":root.userInfo.code,
                                                   "receiverCode": root.currentChatNav.code,
                                                   "type": 0,
                                                   "message": textMessage,//processRichText(textMessage),
                                                   "dateTime": "2025-06-17 21:11:18" })
                           }

        // color: "blue"

    }

    // Component.onCompleted: {
    //     console.log("ChatMessageWindow initiate width: "+root.width)
    // }
}

