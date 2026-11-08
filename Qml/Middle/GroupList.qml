import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//群列表
ColoredFrame{
    id: root
    color: "transparent"  //color: "lightgray" //for test
    padding: 0
    width: 150; height: 300

    property int index: -1

    required property var currentGroup      //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态
    signal selectedGroup(var groupData)     //选中群Item的信号

    //群分组模型
    GroupsModel{ id: groupsModel}

    //设置背景色
    // Rectangle{
    //     anchors.fill: parent
    //     color: "transparent"    // "lightgray" for test
    // }
    //1. ListView 整体列表
    ListView{
        id: listView
        anchors.fill: parent
        anchors.topMargin: 8

        // 注: 不能在顶层ListView中设置margin, 因为 好友item需要贯穿整行的hover效果
        // anchors.leftMargin: 12
        // anchors.rightMargin: 12

        clip: true  //防止内容溢出

        model: groupsModel     //群分组model
        delegate: GroupCategoryDelegate{
            currentGroup: root.currentGroup

            //群item选中处理, 上报父组件
            onSelectedGroup: (data)=>root.selectedGroup(data)
        }
    }
}

