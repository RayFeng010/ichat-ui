import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//聊天导航 item delegate --- UI展示
Item  {
    id: root
    width: ListView.view.width
    height: Math.max(_avatar.height, rowLayout.height) + 5  //高度是头像与内容高度的最大者

    //强制引入devicesModel的几个属性
    required property int index
    required property int senderCode
    required property int receiverCode
    required property string message
    required property string dateTime

    required property var userInfo              //main传入用户信息
    required property var currentChatNav        //设备在线状态

    property int oldWidth: width*0.7            //初始化宽度
    property bool isChatRoom: false
    property var friendInfo:null                     //好友信息

    property string selectedColor: "white"          //选中的颜色
    property string selectedBgColor: "#0099FF"      //选中的背景色

    signal clicked(var chatNavData)                      //此设备被点击事件, 父组件处理: 1. 更新ListView的currentIndex, 更新其他item的selected

    FriendsModel{id: friendsModel}  //好友数据, 根据code查询好友具体信息

    //动态计算是否被选中, 注意根据是否是当前ListView的isCurrentItem和是否 与currentFriend的code相同
    function isSelected(){
        return false
        // if(ListView.isCurrentItem)
        //     return true

        // return false
    }

    // 好友发送的消息布局, 头像靠左, 消息背景白色, 文字黑色
    Row{
        id: rowLayout
        anchors.verticalCenter: root.verticalCenter             //垂直方向居中
        anchors.left: isMyMessage() ? undefined : root.left     //好友发送的消息设置靠左
        anchors.right: isMyMessage() ?  root.right : undefined  //我发送的消息设置靠右
        anchors.leftMargin: 12; anchors.rightMargin: 12         //左右边距12

        //我发送的消息 从右向左布局
        layoutDirection: isMyMessage()?Qt.RightToLeft: Qt.LeftToRight
        height: _msgBubble.height+15            //布局的高度为消息高度, 后续还要添加引用消息
        spacing: 5

        //1. 头像
        HeaderImage{
            id: _avatar
            width: 40; height: 40;
            headerUrl: getHeaderImage()
        }

        //2. 消息内容， 目前只有消息, 后续添加消息引用
        Column {
            id: _column
            y: _avatar.y
            spacing: 3
            //消息头, 群聊时显示消息发送者名
            YaheiText {
                id: headerName
                visible: isChatRoom && !isMyMessage()
                text: root.friendInfo?root.friendInfo.userName:""
                font.pixelSize: 13
                width: 220
                elide: Text.ElideRight
                height: 18
                color: "#636363"
                leftPadding: isMyMessage() ? 0 : 10
                rightPadding: isMyMessage() ? 10 : 0
            }

            //消息内容
            ChatBubble {
                id: _msgBubble
                // y: _column.y+headerName.height+3
                // width: root.getMessageWidth()
                msgText: message
                iconHeight: _avatar.height
                isSend: isMyMessage()? true : false
                maxWidth: root.width>150? root.width - _avatar.width * 2 - 60 -  5:0

            }
        }
    }

    //改变ChatBubble的最大宽度
    onWidthChanged: {
        // console.log("ChatDelegate width changed: " + ListView.view.width+", msgBubble width: "+_msgBubble.width)
        root.changeMessageBubbleWidth()

    }

    Component.onCompleted: {
        root.friendInfo = root.getFriendInfo()  //初始化好友信息
        // console.log("ChatMessageDelegate width: "+root.width+", height: "+root.height)
    }

    //如果消息内容超多, 窗口宽度变化需要动态改变宽度
    function changeMessageBubbleWidth(){
        if(_msgBubble.width > (oldWidth-10)){
             _msgBubble.width = root.width*0.7
            // console.log("ChatDelegate change msgBubble width, old: " + oldWidth+", new: "+ _msgBubble.width)
            oldWidth = _msgBubble.width
        }
    }

    function getMessageWidth(){
        if(_msgBubble.implicitWidth > root.width*0.7){
            // console.log("ChatMessageDelegaten init max width: "+root.width*0.7)
            return root.width*0.7
        }
        return undefined
    }

    //是否为我发送的消息
    function isMyMessage(){
        if(userInfo === null)
            return false
        if(userInfo.code === senderCode)
            return true
        return false
    }

    //获取头像图片
    function getHeaderImage(){
        if(isMyMessage())
            return userInfo?userInfo.header:""

        return friendInfo?friendInfo.header:""
    }

    //我的消息颜色
    function myMessageColor(){
        if(root.isMyMessage())
            return "white"
        return "black"
    }

    //好友的消息颜色
    function friendMessageColor(){
        if(!root.isMyMessage())
            return "black"
        return "white"
    }

    //获取好友信息
    function getFriendInfo(){
        const friendCode=isMyMessage()?root.receiverCode:root.senderCode
        const groupCount=friendsModel.count
        for(var i=0; i<groupCount; i++){
            var group=friendsModel.get(i)
            const friendCout=group.friends.count
            for(var j=0; j<friendCout; j++){
                var friend=group.friends.get(j)
                if(friendCode === friend.code){
                    console.log("Chat message delegate getFriendInfo friend code: "+ friendCode+", friend name: "+friend.userName)
                    return friend
                }
            }
        }
    }

}
