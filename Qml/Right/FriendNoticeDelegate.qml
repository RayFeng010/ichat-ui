import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//设备详细信息 delegate --- UI展示
Rectangle {
    id: root
    width: ListView.view.width; height: 60; radius: 8
    color: "white"  //背景色: 右侧内容底色为灰, 列表背景设置白色, 字体为黑色

    //强制引入Model的几个属性
    required property int index
    required property int initiatorCode             //发起邀请者 code
    required property string initiatorNickName      //发起邀请者昵称
    required property string header                 //好友的头像
    required property int inviteeCode               //受邀者Code
    required property string inviteeNickName        //受邀者昵称
    required property string message                //好友留言
    required property string dateTimeString                 //时间数据
    required property int inviteStatus

    required property int myCode

    property string selectedColor: "white"          //选中的颜色
    property string selectedBgColor: "#0099FF"      //选中的背景色
    //此设备被点击事件, 父组件处理: 1. 更新ListView的currentIndex, 更新其他item的selected

    // 将 ISO 字符串转换为 Date 对象
    readonly property date dateTime: new Date(dateTimeString)

    signal friendClicked(int friendCode)    //点击了好友

    // 通知相信信息布局
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 8

        //头像用矩形包裹
        Rectangle{
            width: 40; height: 40; radius: 20
            Image {
                anchors.fill: parent
                source: header
                // color: "#333"
            }

            //增加鼠标点击小手图标
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.friendClicked(getFriendCode())
            }
        }

        //根据是邀请者还是被邀请者显示不同的信息
        Column{
            width: 200
            spacing: 5
            Row{
                spacing: 5
                //通知信息title
                Text {
                    text: root.getFriendName()
                    color:  "#0099FF"   //亮蓝色
                    font.pixelSize: 14

                    //增加鼠标点击小手图标
                    MouseArea{
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.friendClicked(getFriendCode())
                    }
                }

                //通知信息title
                Text {
                    text: root.getTitleString()
                    color:  "black"
                    font.pixelSize: 14
                }

                //时间
                Text {
                    // 完整日期时间格式化
                    anchors.verticalCenter: parent.verticalCenter
                    text: root.getDateTimeString() //Qt.formatDateTime(dateTime, "yyyy-MM-dd HH:mm")
                    color:  "gray"
                    font.pixelSize: 12
                }
            }

            //好友留言
            Text {
                text: message
                color: "gray"
                font.pixelSize: 12
            }
        }

        //弹簧, 让前面两个布局紧连着
        Item {
            id: spacer
            Layout.fillWidth: true
        }

        //最近的消息时间  + 免打扰图标
        Column{
            width: 100
            spacing: 3
            Button{
                id: btnAgree
                anchors.right: parent.right
                text: qsTr("Agree")
                visible: inviteStatus === 1 && inviteeCode === myCode
            }
            Button{
                id: btnReject
                anchors.right: parent.right
                text: qsTr("Reject")
                visible: inviteStatus === 1 && inviteeCode === myCode
            }

            Text {
                text: inviteStatus === 2? qsTr("Agreed"):qsTr("Rejected")
                anchors.right: parent.right
                visible: inviteStatus != 1
                font.pixelSize: 12
            }
        }
    }

    //通知标题信息--根据是邀请者还是被邀请者显示不同信息
    function getTitleString(){
        var title
        if(myCode === initiatorCode){
            title = qsTr("verifying your initation")
        }
        else{
            title = "requested you as a friend"
        }
        return title
    }

    //获取好友名
    function getFriendName(){
        if(myCode === initiatorCode){
            return inviteeNickName
        }
        else{
            return initiatorNickName
        }
    }

    //获取好友Code
    function getFriendCode(){
        if(myCode === initiatorCode){
            return inviteeCode
        }
        else{
            return initiatorCode
        }
    }

    //获取时间字符串, 今天 只显示时间 HH:mm; 今年：显示: MM-DD; 往年： yyyy-MM-dd HH:mm
    function getDateTimeString(){
        const now = new Date();
        const nowYear = Qt.formatDateTime(now, "yyyy")
        const addYear = Qt.formatDateTime(root.dateTime, "yyyy")

        const diffHours = Math.floor((now - root.dateTime) / 3600000)   //加好友的时间距离现在多少小时

        // console.log("Requested to add a friend " + diffHours + " hours before")
        if(addYear !== nowYear)
            return Qt.formatDateTime(root.dateTime, "yyyy-MM-dd HH:mm")
        else if (diffHours > 24)
            return Qt.formatDateTime(root.dateTime, "MM-dd HH:mm")
        else
            return Qt.formatTime(root.dateTime, "HH:mm")
    }

}
