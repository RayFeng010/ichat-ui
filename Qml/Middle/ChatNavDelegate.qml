import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//聊天导航 item delegate --- UI展示
Rectangle {
    id: root
    width: ListView.view.width
    height: 60

    //强制引入devicesModel的几个属性
    required property int index
    required property int code
    required property string name
    required property string nickName
    required property string header
    required property string lastMessage
    required property string lastDateTime
    required property bool mute             //免打扰状态
    required property bool online           //设备在线状态
    required property bool groupChat        //设备在线状态
    required property var currentChatNav        //设备在线状态

    property bool hovered: false                    //是否鼠标hover, 确定背景色
    property string selectedColor: "white"          //选中的颜色
    property string selectedBgColor: "#0099FF"      //选中的背景色

    signal clicked(var chatNavData)                      //此设备被点击事件, 父组件处理: 1. 更新ListView的currentIndex, 更新其他item的selected

    // color: "#0099FF" //for test

    //背景色: hover/selected/normal
    color: {
        if(isSelected())
            return selectedBgColor
        return hovered? "#F2F2F2":"transparent" //"yellow"  for test
    }

    //动态计算是否被选中, 注意根据是否是当前ListView的isCurrentItem和是否 与currentFriend的code相同
    function isSelected(){
        if(currentChatNav)
        // console.log("currentChatNav code: "+ currentChatNav.code + ", item code: " + root.code)

        if(ListView.isCurrentItem && currentChatNav && currentChatNav.code === code)
            return true

        return false
    }

    //ChatNav item 鼠标事件
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: hovered = true
        onExited: hovered = false
        onClicked: {    //分组展开与关闭
            console.log("Clicked chatNavItem index: "+index+", code: "+ code)
            root.clicked({"index": index, "code": code})  //传递对象
        }
    }

    // 消息导航信息布局
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
        }

        //中间宽度尽量宽
        Column{
            Layout.fillWidth: true
            spacing: 5
            Text {
                width: parent.width
                text: name// + nickName===""?"":"("+ nickName +")"
                elide: Text.ElideRight
                color: {
                    if(isSelected())
                        return selectedColor //"yellow" for test
                    return "black"
                }
                font.pixelSize: 14
            }
            Text {
                width: parent.width
                text: lastMessage
                elide: Text.ElideRight
                color: {
                    if(isSelected())
                        return selectedColor //"yellow" for test
                    return "gray"
                }
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
            width: 60
            spacing: 3
            Text {
                text: lastDateTime
                anchors.right: parent.right
                color: {
                    if(isSelected())
                        return selectedColor //"yellow" for test
                    return "gray"
                }
                font.pixelSize: 10
            }
            Item{
                width: parent.width
                height:text2.height
                Text {
                    id: text2
                    text: mute?"\uf1f7":"\uf0a2" //fa-bell-o
                    anchors.right: parent.right
                    color: {
                        if(isSelected())
                            return selectedColor //"yellow" for test
                        return "gray"
                    }
                    font {
                        family: "FontAwesome"  // 必须与加载的字体名称一致
                        pixelSize: 12
                    }
                }
            }
        }
    }
}
