import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//好友通知列表
Rectangle {
    id: root
    color: "transparent"  //color: "yellow" //for test transparent
    width: 300; height: 400

    property int index: -1

    // 定义ListView的宽度限制（单位：像素）
    property int listViewMinWidth: 460
    property int listViewMaxWidth: 600

    FriendNoticesModel{id: friendNoticesModel} //父组件传入 mode 数据
    FriendsModel{
        id: friendsModel
    }

    //动态调整lisview宽度
    onWidthChanged: {
        if(width > 900)
            listView.width = listViewMaxWidth
        else if(width < 700)
            listView.width = listViewMinWidth
        else
            listView.width = width*0.7
        // console.log("listView parent width: "+width+ ", listView width: "+listView.width)
    }

    //1. ListView 整体列表
    ListView{
        id: listView

        // 动态计算宽度：限制在minWidth~maxWidth之间，且不超过父容器宽度
        height: parent.height

        anchors.top: parent.top                                                 //锚定到parent的top
        anchors.horizontalCenter: parent.horizontalCenter                       //水平居中到listview中
        anchors.topMargin: 25; anchors.rightMargin: 30; anchors.leftMargin: 30; //左右边距30, 上边距25

        spacing: 15

        clip: true  //防止内容溢出

        currentIndex: -1

        property int myCode: 10008

        model: friendNoticesModel             //独立的model文件
        delegate: FriendNoticeDelegate{       //独立的UI展示 delegate
            myCode: listView.myCode
            //传入当前是否选中的参数
            // selected: listView.currentIndex === index

            //某个设备被选中事件处理, 子组件中clicked函数传入device信息, 通过json对象传参
            onFriendClicked: (data)=>{
                                 console.log("Friend code: " + data + " clicked")
                                 profileDialog.showProfile(getFriendInfoByCode(data))
                             }
        }
    }

    //根据friendCode查找此好友的相信信息, 用于弹框显示
    function getFriendInfoByCode(friendCode){
        const count = friendsModel.count
        console.log("Friend count: " + count)
        for(var i=0; i<count; i++){
            var group = friendsModel.get(i)
            const friendCount=group.friends.count
            console.log("Friend group: " + group.name+", friend count: " + friendCount)
            for(var j=0; j<friendCount; j++){
                var friend=group.friends.get(j)
                if(friendCode === friend.code ){
                    console.log("Found friend code: "+friendCode+", userName: "+friend.userName+", nickName: "+friend.nickName)
                    return friend
                }
            }

        }
    }

    //下面的个人信息对话框
    ProfileDialog {
        id: profileDialog
        anchors.fill: parent
    }

}

