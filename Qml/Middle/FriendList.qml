import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//好友分组列表
ColoredFrame{
    id: root
    color: "transparent"  //color: "lightgray" //for test
    padding: 0
    width: 150; height: 300

    property int index: -1  //在StackLayout中的当前索引

    required property var currentFriend     //当前选中的好友

    signal friendSelected(var friendData)

    // 初始化分组号的好友数据模型
    FriendsModel { id: friendsModel }

    //设置背景色
    // Rectangle{
    //     anchors.fill: parent
    //     color: "yellow" //"transparent"    // "lightgray" for test
    // }
    //1. 好友分组顶层 ListView
    ListView{
        id: parentListView
        anchors.fill: parent
        anchors.topMargin: 8

        // 注: 不能在顶层ListView中设置margin, 因为 好友item需要贯穿整行的hover效果
        // anchors.leftMargin: 12
        // anchors.rightMargin: 12

        clip: true  //防止内容溢出

        property int currentGroupId: -1

        model: friendsModel
        delegate: FriendCategoryDelegate{

            //选中好友item事件处理
            currentFriend: root.currentFriend
            onFriendSelected: (data)=>{
                                  // console.log("FriendCategoryList handle frienditem click: ", JSON.stringify(data))
                                  root.friendSelected(data)
                                  // listView.currentGroupId = data.groupId
                              }
        }
    }    
}

