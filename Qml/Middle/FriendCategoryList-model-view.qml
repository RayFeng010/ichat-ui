import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//好友分组列表
ColoredFrame{
    id: root
    color: "transparent"  //color: "lightgray" //for test
    padding: 0
    width: 150; height: 300

    property int index: -1  //在StackLayout中的当前索引

    // 初始化模型
    FriendsModel { id: friendsModel }

    //设置背景色
    // Rectangle{
    //     anchors.fill: parent
    //     color: "yellow" //"transparent"    // "lightgray" for test
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

        model: friendsModel
        delegate: FriendCategoryDelegate{

        }
    }

    //3. 好友delegate --- 好友具体展示UI
    Component {
        id: friendDelegate

        Rectangle {
            id: friendItem
            width: listView.width
            height: 60
            color: hovered? "#F2F2F2":"transparent" //"yellow"  for test

            //强制引入groupModel的几个属性
            required property int index
            required property string name
            required property string header
            property bool hovered: false

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hovered = true
                onExited: hovered = false
                onClicked: {    //分组展开与关闭
                    console.log("Clicked friend index: "+index, ", group name: "+parent.ListView.view.groupName)
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
                        source: header
                        // color: "#333"
                    }
                }

                Text {
                    text: name
                    font.pixelSize: 14
                }

                //右侧弹簧, 让前面两个布局紧连着
                Item {
                    id: spacer
                    Layout.fillWidth: true
                }
            }
        }
    }

    //4. 分组 delegate --- 分组展示UI
    Component{
        id: friendCategoryDelegate

        Column{
            id: groupLo
            width: listView.width
            spacing: 0 // 取消子项间距

            //强制引入groupModel的几个属性
            required property int groupId
            required property int index
            required property string name
            required property bool expanded
            required property int count
            required property var friends

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
                width: parent.width
                height: expanded ? contentHeight : 0
                visible: expanded // 可见性控制

                //拿到当前分组的信息: 分组名
                property string groupName: name
                property int groupId: groupId

                model: friends
                delegate: friendDelegate
                interactive: false
            }
        }
    }
}

