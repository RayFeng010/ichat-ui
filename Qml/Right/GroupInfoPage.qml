import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//群Group信息Page
ColoredFrame{
    id: root
    // width: 300; height: 500

    color: "#F2F2F2"//"yellow"

    property int index: -1

    property alias header: header.headerUrl                //群头像
    property alias groupName: groupNameLabel.text       //群名
    property alias code: codeLabel.text                 //qq
    property alias owner: ownerLabel.text                 //qq
    property alias remark: remarkLabel.text             //备注
    property alias nickName: nickNameLabel.text         //我在本群的昵称
    property alias description: descriptionLabel.text   //全描述
    property alias bulletin: bulletinLabel.text         //公告
    required property int category                      //群分类

    Rectangle{
        id: content
        anchors.centerIn: parent
        width: 500; height: 450//content.height
        color: "white"
        radius: 10

        ColumnLayout{
            anchors.fill: parent
            anchors.topMargin: 20
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            // width: parent.width

            //test
            // Rectangle{
            //     anchors.fill: parent
            //     color: "yellow"
            // }

            //1. 群图片 群名 + 群code
            Rectangle{
                Layout.fillWidth: true
                height: 80
                // color: "lightgray"   //for test

                RowLayout{
                    anchors.fill: parent
                    spacing: 8
                    //1. 图片
                    Rectangle{
                        width: 60; height: 60;
                        // color: "blue"    //for test

                        HeaderImage{
                            anchors.fill: parent
                            id: header
                        }
                    }

                    //纵向布局: 设备名, 在线状态
                    Column{
                        spacing: 6
                        Row{
                            spacing: 3
                            Text {  //姓名---大字体
                                id: groupNameLabel
                                font.pixelSize: 18
                            }
                        }

                        Text {  //群code --- 亮灰色
                            id: codeLabel
                            color: "gray"
                            font.pixelSize: 16
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }
                }
            }

            //分界线
            Rectangle{
                Layout.fillWidth: true
                height: 1
                color: "lightgray"
            }

            //2. 群主
            Rectangle{
                Layout.fillWidth: true
                height: 40
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf256"      //fa-hand-paper-o
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Owner")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: ownerLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //3. 备注
            Rectangle{
                Layout.fillWidth: true
                height: 40
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf044"      //fa-pencil-square-o
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Remark")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: remarkLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //4. 我在本群的昵称
            Rectangle{
                height: 40
                Layout.fillWidth: true
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf02b"      //fa-tag
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Nickname in Group")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: nickNameLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //5. 群介绍
            Rectangle{
                height: 40
                Layout.fillWidth: true
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf298"      //fa-wpforms
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Description")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: descriptionLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //6. 群公告
            Rectangle{
                height: 40
                Layout.fillWidth: true
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf298"      //fa-wpforms
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Bulltin")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: bulletinLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //7. 群分组
            Rectangle{
                height: 40
                Layout.fillWidth: true
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf114"      //fa-folder
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Category")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    //todo CheckBox
                    ComboBox{
                        id: categoryLabel
                        editable: true
                        model: ["Middle School", "Home", "High School"]
                        Layout.alignment: Qt.AlignRight
                    }
                }
            }

            //最下面的弹簧 --- 撑满高度
            Item {
                id: spacer
                Layout.fillHeight: true
            }
        }
    }

    Component.onCompleted: {
        console.log("GroupInfoPage initiate widht: "+root.width)
    }
}

