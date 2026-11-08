import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//通信录
ColoredFrame{
    id: root
    color: "lightgray"
    padding: 0

    property alias index: stackLayout.currentIndex  //最下面的列表栈索引

    required property var currentChatNav          //当前选中的聊天Nav--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态

    signal chatNavSelected(var chatNavData)           //选中聊天导航的信号---参数为设备信息的json对象

    //4. StackLayout 好友分组/群/设备列表
    StackLayout{
        id: stackLayout
        anchors.fill: parent
        // Layout.fillWidth: true
        // Layout.fillHeight: true

        //聊天导航列表
        ChatNavList{
            id: chatNavList
            width: parent.width
            height: parent.height
            index: 0
            currentChatNav: root.currentChatNav

            onChatNavSelected: (data)=>{
                                  // console.log("ContactNavWindow handle frienditem click: ", JSON.stringify(data))
                                  root.chatNavSelected(data)
                              }
        }

        //群列表

    }


}
