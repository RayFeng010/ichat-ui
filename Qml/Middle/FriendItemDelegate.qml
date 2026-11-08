import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//分组的好友item delegate --- UI展示
Rectangle {
    id: root
    width: ListView.view.width
    height: 60

    //强制引入groupModel的几个属性
    required property int index             //index --- 用于 确定是否选中
    required property int groupId           //分组ID
    required property string groupName      //分组名

    required property string userName       //好友名
    required property string nickName       //昵称
    required property int code              //唯一code
    required property string header         //头像
    required property string gender         //性别
    required property string birthday       //生日

    required property string city           //居住地
    required property string remark         //对好友的备注
    required property string signature      //好友的签名
    required property bool online           //是否在线

    required property var currentFriend     //当前选中的好友 --- 重要: 用于跨分组的好友选中与取消

    property bool hovered: false
    property string selectedColor: "white"          //选中的颜色
    property string selectedBgColor: "#0099FF"      //选中的背景色

    //此设备被点击事件, 父组件处理: 1. 更新ListView的currentIndex, 更新其他item的selected
    signal clicked(var friendData) //friendInfo以json格式返回

    //动态计算是否被选中, 注意根据是否是当前ListView的isCurrentItem和是否 与currentFriend的code相同
    function isSelected(){
        // console.log("currentFriend code: "+ currentFriend.code + ", item code: " + root.code)
        if(ListView.isCurrentItem && currentFriend && currentFriend.code === code)
            return true

        return false
    }

    //选中背景色：蓝色,字体白色
    color: {
        if(isSelected())
            return selectedBgColor
        return hovered? "#F2F2F2":"transparent" //"yellow"  for test
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: hovered = true
        onExited: hovered = false

        //好友item点击, 上报父组件FriendCategoryDelegate.qml
        onClicked: {
            console.log("Clicked friend index: "+index, ", group name: "+parent.ListView.view.groupName)
            root.clicked({"index": index, "groupId": groupId, "groupName": groupName, "userName": userName,"nickName": nickName,"code": code, "header": header,
                         "birthday": birthday,"gender": gender,"remark": remark,"signature": signature,"online": online, "city": city})
        }
    }

    // 好友信息布局
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 8

        //头像用矩形包裹
        Rectangle{
            width: 40; height: 40; radius: 20
            HeaderImage {
                anchors.fill: parent
                headerUrl: header
                // color: "#333"
            }
        }

        Text {
            text: userName
            font.pixelSize: 14
            color: {
                if(isSelected())
                    return selectedColor //"yellow" for test
                return "black"
            }
        }

        //右侧弹簧, 让前面两个布局紧连着
        Item {
            id: spacer
            Layout.fillWidth: true
        }
    }
}
