import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: listView.width
    height: 60

    //强制引入groupModel的几个属性
    required property int index
    required property int groupId
    required property int code              //唯一code
    required property string name
    required property string header
    required property int owner
    required property string nickName
    required property string remark
    required property string description
    required property int category
    required property string bulletin

    required property var currentGroup      //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态

    property bool hovered: false
    property string selectedColor: "white"          //选中的颜色
    property string selectedBgColor: "#0099FF"      //选中的背景色

    signal clicked(var groupData)

    //动态计算是否被选中, 注意根据是否是当前ListView的isCurrentItem和是否 与currentFriend的code相同
    function isSelected(){
        // if(currentGroup)
        //     console.log("currentGroup code: "+ currentGroup.code + ", item code: " + root.code)
        if(ListView.isCurrentItem && currentGroup && currentGroup.code === root.code)
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
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: {    //分组展开与关闭
            console.log("Clicked group index: "+index, ", group name: "+parent.ListView.view.groupName)

            //构造当前选中的群的json对象, 用于右侧群详情显示
            root.clicked({"index":index, "code":code, "name":name, "header":header, "owner":owner, "nickName":nickName, "remark":remark,
                             "description":description, "category":category, "bulletin":bulletin})
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
            Image {
                anchors.fill: parent
                source: root.header
                // color: "#333"
            }
        }

        Text {
            text: root.name
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
