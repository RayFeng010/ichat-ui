import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    function showProfile(user) {        //C++ QmlProfileViewer::showProfile 调用的函数, 参数User::Handle, 在下面的对话框中显示
        localProfileViewer.showProfle(user)
    }
    
    Dialog {                        //对话框 250 x 400
        id: localProfileViewer

        anchors.centerIn: parent
        width: 400; height: 300
        modal: true

        property var user    //C++中定义的用户信息数据结构 UserHandle

        //对话框最底层背景样式--上部分渐变 -- 下部分为底色
        background: Rectangle {
            anchors.fill: parent
            radius: 10                      //背景圆角 半径30, 上部分蓝色背景圆角相同
            color: "white"

            //渐变色
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#C5CBE0"    //背景上部分为浅蓝色
                    //color: "blue"
                }
                GradientStop {
                    position: 0.3
                    //color: "#F5F5F5"
                    color: "white"       //chris 202505
                }
                GradientStop {
                    position: 1
                    //color: "#6482f0"
                    color: "white"       //chris 202505
                }
            }
        }

        header: Rectangle{
            height: 30
            color: "green"
        }

        ColumnLayout{
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            anchors.topMargin: 30           //位置距离顶部30px
            spacing: 6

            //头像 CODE name nickName
            RowLayout {
                width: parent.width

                //左边--圆形头像-- 宽高均为 70,半径为70, 实则圆
                Rectangle {
                    width: 60; height: 60//; radius:70
                    // color:Material.background

                    //头像
                    Image {
                        id: icon
                        anchors.centerIn:parent
                        source: localProfileViewer.user?localProfileViewer.user.header:"images/linux.png"                          //图片svg
                        sourceSize.height: 60; sourceSize.width: 60         //图片宽高, 比背景小10
                    }
                }

                //右边--用户信息, 显示两行刚好 name在上半部分, tag在下部分, 后续需要优化样式
                Column {
                    spacing:5
                    Layout.fillWidth:true

                    //用户名Label
                    Label {
                        id: nameLbl
                        elide: Qt.ElideRight                    //文字太宽从右省略
                        width:parent.width
                        text: localProfileViewer.user?localProfileViewer.user.userName:""      //用户名
                        font.pointSize: 14
                        font.bold: true
                    }

                    //用户tag Label
                    Label {
                        id: tagLbl
                        width:parent.width
                        elide: Qt.ElideRight                    //文字太长设置为从右省略
                        property string tag
                        text: localProfileViewer.user?localProfileViewer.user.nickName:"" //用户tag
                        font.pointSize: 10
                    }
                }
            }

            Item{
                height: 20
            }

            //备注
            Rectangle{
                Layout.fillWidth: true
                height: 35
                color: "transparent"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Rectangle{
                        width: 80
                        height: parent.height
                        Text {
                            anchors.fill: parent
                            text: qsTr("Remark")
                            font.pixelSize: 14
                        }
                    }

                    Rectangle{
                        Layout.fillWidth: true
                        height: parent.height
                        Text {
                            id: remarkLabel
                            text: localProfileViewer.user?localProfileViewer.user.remark:""
                            font.pixelSize: 14
                        }
                    }


                }
            }

            //签名
            Rectangle{
                Layout.fillWidth: true
                height: 35
                color: "transparent"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Rectangle{
                        width: 80
                        height: parent.height
                        Text {
                            text: qsTr("Signature")
                            font.pixelSize: 14
                        }
                    }

                    Rectangle{
                        Layout.fillWidth: true
                        height: parent.height
                        Text {
                            id: signatureLabel
                            text: localProfileViewer.user?localProfileViewer.user.signature:""
                            font.pixelSize: 14
                        }
                    }
                }
            }

            Item{
                Layout.fillHeight: true
            }

        }


        
        //将user赋值给qml的对话框中的user, 执行open对话框
        function showProfle(user) {
            localProfileViewer.user = user
            open()
        }
    }

}
