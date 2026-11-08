import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//设备信息Page
ColoredFrame{
    id: root
    // width: 300; height: 500

    color: "#F2F2F2"//"yellow"

    property int index: -1

    property string os : "windows"                       //os类型
    property alias deviceName: deviceNameLable.text     //设备名
    property bool online: false                         //在线状态
    property alias cpuCores: cpuCoresLabel.text         //cpu核数
    property alias memory: memoryLabel.text             //内存
    property alias hardDisk: hdLabel.text               //硬盘
    property alias display: displayLabel.text           //显卡

    // required property var currentDevice

    // Component.onCompleted: {
    //     root.os = currentDevice?currentDevice.os:""
    //     root.deviceName = currentDevice?currentDevice.deviceName:""
    //     root.online = currentDevice?currentDevice.online:false
    //     root.cpuCores = currentDevice?currentDevice.cpuCores:""
    //     root.memory = currentDevice?currentDevice.memory:""
    //     root.hardDisk = currentDevice?currentDevice.hardDisk:""
    //     root.display = currentDevice?currentDevice.display:""
    // }

    //根据os类型返回对应的图片
    function getImage(os){
        if(os === "windows")
            return "images/windows.png"
        else if(os === "linux")
            return "images/linux.png"
        else if(os === "android")
            return "images/android.png"
        else if(os === "mac")
            return "images/mac.png"
        else
            return ""
    }

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
                        width: 60; height: 60
                        // color: "blue"    //for test
                        Image{
                            anchors.fill: parent
                            id: osImage
                            source: getImage(root.os)
                        }
                    }

                    //纵向布局: 设备名, 在线状态
                    Column{
                        spacing: 6
                        Text {  //姓名---大字体
                            id: deviceNameLable
                            font.pixelSize: 18
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
                                font.pixelSize: 14
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

            //2. CPU核数
            Rectangle{
                Layout.fillWidth: true
                height: 40
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        id: name
                        text: "\uf1cd"      //fa-life-saver
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("CPU Cores")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: cpuCoresLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //3. 内存
            Rectangle{
                height: 40
                Layout.fillWidth: true
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf2db"      //fa-micro-chip
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Memory")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: memoryLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //4. 硬盘
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
                        text: qsTr("HardDisk")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: hdLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //5. 显卡
            Rectangle{
                height: 40
                Layout.fillWidth: true
                // color: "green"
                RowLayout{
                    anchors.fill: parent
                    spacing: 6

                    Text {
                        text: "\uf26c"      //fa-television
                        font {
                            family: "FontAwesome"  // 必须与加载的字体名称一致
                            pixelSize: 18
                        }
                    }
                    Text {
                        text: qsTr("Display")
                        font.pixelSize: 14
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: displayLabel
                        Layout.alignment: Qt.AlignRight
                        font.pixelSize: 14
                    }
                }
            }

            //最后 弹簧--撑满高度
            Item {
                id: spacer
                Layout.fillHeight: true
            }
        }
    }
}

