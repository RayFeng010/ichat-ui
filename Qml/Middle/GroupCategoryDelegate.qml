import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Column{
    id: root
    width: listView.width
    spacing: 0 // 取消子项间距

    //强制引入groupModel的几个属性
    required property int groupId
    required property int index
    required property string name
    required property bool expanded
    required property int count
    required property var groups            //模型中的群列表

    required property var currentGroup      //当前选中的群--作用: 1. 右侧显示群的详细信息; 2. 群Item的选中背景状态

    signal selectedGroup(var groupData)     //选中群Item的信号

    // 1. 群分组标题（单行）
    Rectangle {
        width: parent.width
        height: 35 // 固定高度确保单行
        // color: "#f0f0f0" //for分组单行 宽高测试

        MouseArea {
            anchors.fill: parent
            onClicked: {    //分组展开与关闭
                console.log("Group category clicked index: "+ index+ ", groupId: " + groupId+", expanded: "+ expanded)
                expanded = !expanded
            }
        }

        //分组item一行的显示
        RowLayout{
            anchors.fill: parent

            //这里设置分组内容的左右margin, 不要在顶层ListView中同一设置margin
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            spacing: 8

            //左边字体图标: 右箭头or下箭头 -- 根据展开状态, 字体图标用Rectangle包裹, 否则图标宽度变化影响后面的分组名显示
            Rectangle{
                id: icon
                // width: 10    //有上面的spacing, 这里不用设置宽度
                //color: "yellow"   //无效
                Text {
                    anchors.centerIn: parent
                    text: expanded?"\uf107":"\uf105"  //fa-angle-right f105 fa-angle-down f107
                    // verticalAlignment: Text.AlignVCenter
                    font {
                        family: "FontAwesome"  // 必须与加载的字体名称一致
                        pixelSize: 16
                    }
                }
            }

            //分组or群名
            Text {
                id: groupName
                text: name
                font.pixelSize: 14
            }

            //分组人数靠右
            Text {
                id: countLabel
                Layout.alignment: Qt.AlignRight

                color: "gray"
                text: count
                font.pixelSize: 12
            }
        }
    }

    // 2. 好友列表（动态高度）
    ListView {
        id: groupListView
        width: parent.width
        height: expanded ? contentHeight : 0
        visible: expanded // 可见性控制

        //拿到当前分组的信息: 分组名
        property string groupName: name
        property int groupId: groupId

        model: groups
        delegate: GroupItemDelegate{
            currentGroup: root.currentGroup

            //群item选中信号
            onClicked: (data)=>{
                           groupListView.currentIndex = data.index  //此行代码必须添加, 否则群item选中会出现列表中第一个item可以被选中
                           root.selectedGroup(data)
                       }
        }

        interactive: false
    }
}
