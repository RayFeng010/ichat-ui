import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//好友分组title delegate --- UI展示
//由于有二级展开的好友列表, 因此顶层未Column， 上面为分组标题行, 下面为列表
Column{
    id: root
    width: ListView.view.width
    spacing: 0 // 取消子项间距

    //强制引入groupModel的几个属性
    required property int groupId
    required property int index
    required property string name
    required property int count
    required property var friends

    property bool expanded: false   //默认未展开

    required property var currentFriend

    //选中好友事件
    signal friendSelected(var friend)

    property alias model: friendsListView.model

    // 1. 分组标题（单行）
    Rectangle {
        width: parent.width
        height: 35 // 固定高度确保单行
        // color: "#f0f0f0" //for分组单行 宽高测试

        MouseArea {
            anchors.fill: parent
            onClicked: {    //分组展开与关闭
                console.log("Clicked group expanded: ", index, expanded)
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
        id: friendsListView
        currentIndex: -1
        width: parent.width
        height: expanded ? contentHeight : 0    //根据展开状态动态扩展高度为列表所有内容的高度
        visible: expanded // 可见性控制

        //拿到当前分组的信息: 分组名
        property string groupName: name
        property int groupId: groupId

        model: friends
        delegate: FriendItemDelegate{

            //当前FriendItem是否被选中, 特殊背景色: 蓝色, 字体: 白色
            currentFriend: root.currentFriend
            groupName: groupName

            //好友item被点击, 上报好友选择事件
            onClicked: (data)=>{
                           console.log("FriendCategoryDelegate handle frienditem click: ", JSON.stringify(data))
                           friendsListView.currentIndex = data.index
                           root.friendSelected(data)
                       }
        }

        interactive: false
    }
}
