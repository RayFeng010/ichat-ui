import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//好友信息Page
ColoredFrame{
    id: root
    // width: 300; height: 500

    color: "#F2F2F2"//"yellow"

    property int index: -1

    property alias header: header.headerUrl           //好友头像
    property alias userName: userNameLabel.text         //用户名
    property alias nickName: nickNameLabel.text         //昵称
    property alias code: codeLabel.text                     //qq
    property alias gender: genderLabel.text         //昵称
    property alias birthday: birthdayLabel.text         //生日
    property alias city: cityLabel.text                 //城市
    property alias remark: remarkLabel.text             //备注
    property alias signature: signatureLabel.text       //签名
    property bool online: false                         //在线状态

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
            Layout.minimumWidth: 400
            // width: parent.width

            //test
            // Rectangle{
            //     anchors.fill: parent
            //     color: "yellow"
            // }

            //1. os图片 设备名， 在线状态
            Rectangle{
                Layout.fillWidth: true
                height: 80
                // color: "lightgray"   //for test

                RowLayout{
                    anchors.fill: parent
                    spacing: 8
                    //1. OS 图片
                    Rectangle{
                        width: 60; height: 60;
                        // color: "blue"    //for test

                        HeaderImage{
                            anchors.fill: parent
                            id: header

                        }
                    }

                    //纵向布局: 用户名,qq, 在线状态
                    Column{
                        spacing: 6
                        Row{
                            spacing: 3
                            Text {  //姓名---大字体
                                id: userNameLabel
                                font.pixelSize: 16
                            }
                            Text {
                                text: "--"
                            }
                            Text {  //姓名---大字体
                                id: nickNameLabel
                                font.pixelSize: 16
                            }
                        }

                        Text {  //qq --- 亮灰色
                            id: codeLabel
                            color: "gray"
                            font.pixelSize: 12
                        }

                        //横向布局 在线状态图标+ 文字
                        Row{
                            spacing: 6
                            Text {
                                text: "\uf111"      //fa-circle
                                color: online?"green":"lightgray"
                                font {
                                    family: "FontAwesome"  // 必须与加载的字体名称一致
                                    pixelSize: 18
                                }
                            }
                            Text {  //在线状态
                                text: root.online?qsTr("Online"):qsTr("Offline")
                                font.pixelSize: 12
                            }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }
                    Column{
                        spacing: 6
                        Text {
                            id: testAlign
                            Layout.alignment: Qt.AlignRight
                            text: "\uf087"
                            font {
                                family: "FontAwesome"  // 必须与加载的字体名称一致
                                pixelSize: 18
                            }
                        }
                        Text {
                            Layout.alignment: Qt.AlignRight
                            text: "999"
                        }
                    }
                }
            }

            //分界线
            Rectangle{
                Layout.fillWidth: true
                height: 1
                color: "lightgray"
            }

            //2. 好友综合信息
            Rectangle{
                Layout.fillWidth: true
                height: 40
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {  //性别
                        id: genderLabel
                    }
                    Text {
                        text: " | "
                    }
                    Text {  //生日
                        id: birthdayLabel
                    }
                    Text {
                        text: " | "
                    }
                    Text {  //居住地
                        id: cityLabel
                    }
                    Item {
                        Layout.fillWidth: true
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
                        id: name
                        text: "\uf044"      //fa-pencil-square-o
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Remark")
                        color: "gray"
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: remarkLabel
                        Layout.alignment: Qt.AlignRight
                        // text: qsTr("32")
                        font.pixelSize: 14
                    }
                }
            }

            //3. 签名
            Rectangle{
                height: 40
                Layout.fillWidth: true
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf040"      //fa-pencil
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Signature")
                        color: "gray"
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: signatureLabel
                        Layout.alignment: Qt.AlignRight
                        // text: qsTr("32")
                        font.pixelSize: 14
                    }
                }
            }

            //4. 分组
            Rectangle{
                height: 40
                Layout.fillWidth: true
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf1c0"      //fa-database
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Category")
                        color: "gray"
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

            // 弹簧 --- 撑满高度
            Item {
                id: spacer
                Layout.fillHeight: true
            }


            //7. 操作区
        }

    }


}

