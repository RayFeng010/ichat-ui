import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects              //QT6替代QT5下面的GraphicalEffects 性能更好
// import Qt5Compat.GraphicalEffects   //导致UI模糊

import QianControls 1.0
// import Qian.QuickKit 1.0    //C++的QuickKit: 无边框窗口, gif表情包

//C++的无边框类FramelessWindow
FramelessWindow {
    id: rootWindow
    width: 980; height: 660
    visible: true
    color: "transparent"
    minimumWidth: 920; minimumHeight: 660
    resizable:  true

    property int currentMiddleIndex: 0            //默认选中第一个工具条按钮
    property int currentRightIndex: 0       //默认右侧内容窗口
    property int userCode: 10008            //用户配置, 黄蓉
    property var currentUser: null          //当前用户

    property var currentDevice: null        //当前选中的设备
    property var currentFriend: null        //当前选中的好友
    property var currentGroup: null         //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态
    property var currentChatNav: null

    // 1. 加载字体图标
    FontLoader {
        id: awesomeFont
        source: Qt.resolvedUrl("fonts/fontawesome-webfont.ttf") // 字体文件需放入qrc资源系统
        onStatusChanged: {
            if (status === FontLoader.Ready) console.log("字体加载成功")
            else console.log("字体加载状态:", status)
        }
    }

    // 2. 左边/上边一定范围可以拖动窗口
    property var mainMoveArea: [
        Qt.rect(0, 0, 66, 99999),     // 左侧
        Qt.rect(0, 0, 99999, 70)      // 顶部
    ]

    moveArea:  mainMoveArea //C++无边框类的属性

    // 3. 设置边框  //整个窗口的背景
    Rectangle {
        anchors.fill: parent
        border.color: "lightgray"
        border.width: 1
    }

    // 4. 主窗口: 横向布局: 左边 导航工具栏 --- 右边 SpliteView
    RowLayout {
        anchors.fill: parent
        anchors.margins: 1  //必须添加边距, 否则上面的边框无效
        spacing: 0

        //1.左边工具条
        NavigationBar {
            id: navBar
            width: 66; Layout.fillHeight: true

            //左边导航工具条选中切换, 中间导航窗口做对应切换, 右边窗口置空
            onItemSelected: (index)=>{
                                if(index === 4)
                                    profileDialog.visible = true

                                message('success', "NaviBar clicked!");
                                rootWindow.currentMiddleIndex = index
                                mainWindow.rightContentIndex = 0        //工具条切换将右侧窗口重置 //这里改变 rootWindow.currentRightIndex 无效 why
                                mainWindow.currentDevice = null
                                mainWindow.currentFriend = null
                                mainWindow.currentGroup = null
                                mainWindow.currentChatNav = null

                                console.log("NavBar: selected index: " + index + ", rightConttentIndex: " + mainWindow.rightContentIndex)
                            }
        }

        //2. 右边窗口
        MainWindow{
            id: mainWindow
            Layout.fillWidth: true; Layout.fillHeight: true     //撑满宽度与高度
            middleNavIndex: rootWindow.currentMiddleIndex       //NavBar点击更新切换中间窗口
            rightContentIndex: rootWindow.currentRightIndex     //右侧窗口索引初始化为root初始化的值, 后续的切换可以通过NaviBar切换
            userInfo: rootWindow.currentUser

            //中间导航tab list中当前选中的item
            currentFriend: rootWindow.currentFriend
            currentGroup: rootWindow.currentGroup
            currentChatNav: rootWindow.currentChatNav
            currentDevice: rootWindow.currentDevice}


        // layer.enabled: true
        // layer.effect: DropShadow {     }
    }

    FriendsModel{ id:friendsModel}

    Component.onCompleted: {
        rootWindow.currentUser = getUserInfo() //初始化用户信息
    }

    //根据上面配置的用户code获取用户信息, 全局使用
    function getUserInfo(){
        const groupCount = friendsModel.count
        for(var i=0; i< groupCount; i++){
            var group=friendsModel.get(i)
            const friendCount=group.friends.count
            for(var j=0; j<friendCount; j++){
                var friend=group.friends.get(j)
                if(friend.code === rootWindow.userCode){
                    console.log("Initiated user code: " + rootWindow.userCode + ", userName: " + friend.userName)
                    return friend
                }
            }
        }
    }

    //QianQuickContorls, 顶部消息提示框
    Message{
        id:messageTip
        z: 1
        parent: Overlay.overlay
    }

    //消息提示
    function message(type, message) {
        if(type!=='success'&&type!=='error'&&type!=='info'){
            return false
        }
        messageTip.open(type, message)
    }

    Dialog {
        id: profileDialog
        width: 300
        height: 400
        // flags: Qt.FramelessWindowHint // 必须无边框才能拖拽

        modal: true

        header:Rectangle{
            height: 30
            color: "green"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            MouseArea{
                anchors.fill: parent
                drag.target: profileDialog
                enabled: true
            }

            //关闭按钮
            SystemButton {
                id: closeButton
                height: parent.height
                width:height*1.5
                anchors.right: parent.right
                text: "🗙"
                background: Rectangle {
                    color: {
                        if (!closeButton.enabled) {
                            return "lightgray"
                        }
                        if (closeButton.hovered) {
                            return "#e81123"
                        }
                        return "transparent"
                    }
                }
                onClicked: {
                    profileDialog.close()
                }
            }

        }
    }

    //拖拽层次感比较好, 性能更好, 下面QT5的导致UI模糊
    // MultiEffect {
    //         anchors.fill: parent
    //         source: rootWindow
    //         shadowEnabled: true
    //         shadowColor: "black"
    //         shadowBlur: 0.4  // 模糊强度（0~1）
    //         shadowHorizontalOffset: 3
    //         shadowVerticalOffset: 3
    //     }
}
