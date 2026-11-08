import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//右边切分窗口
SplitView{
    id: root
    // required property Window window         //root window 用于拖动/最大化/正常显示窗口

    required property var userInfo                                      //父组件传入用户数据, Main中初始化, navBar中也需要此信息

    property alias middleNavIndex: middleNavWindow.stackIndex           //默认选中最上面的按钮
    property alias rightContentIndex: rightContentWindow.stackIndex     //默认为空 Page

    property alias currentDevice: middleNavWindow.currentDevice         //当前选中的设备
    property var currentFriend: middleNavWindow.currentFriend           //当前选中的好友
    property var currentGroup: middleNavWindow.currentGroup             //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态
    property var currentChatNav: middleNavWindow.currentChatNav

    //splitView分割线自定义样式
    handle: Rectangle {
        id: handleDelegate
        implicitWidth: 2
        color: SplitHandle.pressed ? "#E9E9E9"
                                   : (SplitHandle.hovered ? Qt.lighter("#E9E9E9", 0.8) : "#E9E9E9")

        MouseArea {
            anchors.fill: parent
            // hoverEnabled: true
            cursorShape: Qt.SizeHorCursor // 设置自定义光标（横向分割条）
        }

        //在分割线两边8px都可以显示分隔标识, 这样容易选中分隔, 但出现光标不能保持上面设置的
        // containmentMask: Item {
        //     x: (handleDelegate.width - width) / 2
        //     width: 4
        //     height: root.height
        // }
    }

    spacing: 0

    //中间导航窗口
    MiddleNavWindow{
        id: middleNavWindow
        SplitView.preferredWidth: 240   //初始化宽度220
        SplitView.minimumWidth: 220
        SplitView.maximumWidth: 420     //最宽350px
        Layout.fillHeight: true

        stackIndex: root.middleNavIndex    //中间窗口栈的切换索引0: ContactNavWindow 1: ChatNavWindow

        //中间导航tab list中当前选中的item
        currentFriend: root.currentFriend
        currentGroup: root.currentGroup
        currentChatNav: root.currentChatNav
        // cuurrentDevice: root.currentDevice

        //点击了好友通知
        onFriendNoticeClicked: {

            //取消所有friendTab的选中
            root.currentDevice = null
            root.currentFriend = null
            root.currentGroup = null
            root.rightContentIndex = 4   //切换右侧内容为好友通知列表
        }


        //选中了设备的事件
        onDeviceSelected: (data)=>{
                              // console.log("MainWindow handle selected device: "+JSON.stringify(data))
                              root.currentDevice = data
                              root.currentFriend = null
                              root.currentGroup = null
                              root.rightContentIndex = 1
                          }

        //选中了好友
        onFriendSelected: (data)=>{
                              // console.log("MainWindow handle frienditem click: ", JSON.stringify(data))
                              root.currentFriend = data
                              root.currentDevice = null
                              root.currentGroup = null
                              root.rightContentIndex = 2
                          }

        //群item选中处理, 上报父组件
        onSelectedGroup: (data)=>{
                             console.log("MainWindow handle groupItem click: ", JSON.stringify(data))
                             root.currentGroup = data
                             root.currentDevice = null
                             root.currentFriend = null
                             root.rightContentIndex = 3
                         }

        onChatNavSelected: (data)=>{
                               console.log("MainWindow handle chatNav click: ", JSON.stringify(data))
                               root.currentChatNav = data
                               root.rightContentIndex = 5
                           }
    }

    //右边内容窗口
    RightContentWindow{
        id: rightContentWindow
        stackIndex: root.rightContentIndex

        SplitView.fillWidth: true
        SplitView.minimumWidth: 520
        Layout.fillWidth: true

        //右边内容窗口当前信息初始化
        userInfo: root.userInfo
        currentDevice: root.currentDevice
        currentFriend: root.currentFriend
        currentGroup: root.currentGroup
        currentChatNav: root.currentChatNav

    }

}

