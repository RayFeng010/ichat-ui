import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//好友分组列表
ColoredFrame{
    id: root
    color: "transparent"  //color: "lightgray" //for test
    padding: 0
    width: 150; height: 300

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

        model: friendGroupModel
        delegate: friendGroupDelegate
    }

    //2. model 分组和联系人
    ListModel{
        id: friendGroupModel
        ListElement{
            groupId: 101
            name:"My Devices"    //我的设备列表
            expanded: true
            count: 10    //分组中的数量
            friends: [
                ListElement { name: "爸爸"; phone: "13800138000"; header: "images/man.png" },
                ListElement { name: "妈妈"; phone: "13800138001"; header: "images/woman.png"}
            ]
        }
        ListElement{
            groupId: 102
            name:"My Group"  //我加入的分组
            expanded: false
            count: 32    //分组中的数量
            friends: [
                ListElement { name: "张三"; phone: "13800138002"; header: "images/panda.png" },
                ListElement { name: "李四"; phone: "13800138003"; header: "images/little_boy.png" },
                ListElement { name: "王五"; phone: "13800138004"; header: "images/little_girl_1.png" }
            ]
        }
        ListElement{
            groupId: 1001
            name: "莲花一村"  //我加入的分组
            expanded: false
            count: 113    //分组中的数量
            friends: [
                ListElement { name: "黄蓉"; phone: "13800138002"; header: "images/firefox.png" },
                ListElement { name: "郭靖"; phone: "13800138003"; header: "images/msn.png" },
                ListElement { name: "张无忌"; phone: "13800138004"; header: "images/qq.png" }
            ]
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
                onEntered: friendItem.hovered = true
                onExited: friendItem.hovered = false
                onClicked: {    //分组展开与关闭
                    console.log("Clicked friend index: "+index)
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
        id: friendGroupDelegate

        Column{
            id: groupLo
            width: listView.width
            spacing: 0 // 取消子项间距

            //强制引入groupModel的几个属性
            required property int index
            required property string name
            required property bool expanded
            required property int count
            required property int groupId
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
                        friendGroupModel.setProperty(index, "expanded", !expanded)
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
                            text: groupLo.expanded?"\uf107":"\uf105"  //fa-angle-right f105 fa-angle-down f107
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
                        text: groupLo.name
                        font.pixelSize: 14
                    }

                    //分组人数靠右
                    Text {
                        id: countLabel
                        Layout.alignment: Qt.AlignRight

                        color: "gray"
                        text: groupLo.count
                        font.pixelSize: 12
                    }
                }
            }

            // 2. 好友列表（动态高度）
            ListView {
                width: parent.width
                height: groupLo.expanded ? contentHeight : 0
                visible: groupLo.expanded // 可见性控制
                model: groupLo.friends
                delegate: friendDelegate
                interactive: false
            }

            // 动态加载好友列表
            /*Loader {
                id: listLoader
                width: parent.width
                height: active ? item.height : 0
                active: groupLo.expanded // 仅当展开时激活

                sourceComponent: Component {
                    ListView {
                        width: parent.width
                        height: contentHeight
                        model: friends
                        delegate: friendDelegate
                        interactive: false

                        // 添加动画（可选）
                        // Behavior on height {
                        //     NumberAnimation { duration: 150 }
                        // }
                    }
                }
            }*/
        }
    }

}
