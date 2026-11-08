import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//设备详细信息 delegate --- UI展示
Rectangle {
    id: root
    width: ListView.view.width
    height: 60

    //强制引入devicesModel的几个属性
    required property int index
    required property string deviceId
    required property string name
    required property string header
    required property string os
    required property string cpu
    required property string memory
    required property string harddisk
    required property string display
    required property bool online       //设备在线状态

    required property var currentDevice             // 当前选中设备

    property bool hovered: false                    //是否鼠标hover, 确定背景色
    property string selectedColor: "white"          //选中的颜色
    property string selectedBgColor: "#0099FF"      //选中的背景色

    signal clicked(var device)                      //此设备被点击事件, 父组件处理: 1. 更新ListView的currentIndex, 更新其他item的selected

    // color: "#0099FF" //for test

    //背景色: hover/selected/normal
    color: {
        if(isSelected())
            return selectedBgColor
        return hovered? "#F2F2F2":"transparent" //"yellow"  for test
    }

    //动态计算是否被选中, 注意根据是否是当前ListView的isCurrentItem和是否 与currentFriend的code相同
    function isSelected(){
        // if(currentDevice)
            // console.log("currentFriend code: "+ currentDevice.deviceId + ", item deviceId: " + root.deviceId)

        if(ListView.isCurrentItem && currentDevice && currentDevice.deviceId === deviceId)
            return true

        return false
    }

    //设备item 行鼠标事件
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: hovered = true
        onExited: hovered = false
        onClicked: {    //分组展开与关闭
            // console.log("Clicked device index: "+index)
            root.clicked({"index": index, "deviceId": deviceId,  "name": name, "header": header, "os": os, "cpu": cpu, "memory": memory, "harddisk": harddisk, "display": display, "online": online})  //传递对象
        }
    }

    // 设备相信信息布局
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

        Text {
            text: name
            color: {
                if(isSelected())
                    return selectedColor //"yellow" for test
                return "black"
            }
            font.pixelSize: 14
        }

        //右侧弹簧, 让前面两个布局紧连着
        Item {
            id: spacer
            Layout.fillWidth: true
        }
    }
}
