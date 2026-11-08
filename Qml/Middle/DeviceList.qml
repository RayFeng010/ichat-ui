import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//群列表
ColoredFrame{
    id: root
    color: "transparent"  //color: "lightgray" //for test
    padding: 0
    width: 150; height: 300

    property int index: -1  //在StackLayout中的当前索引

    required property var currentDevice             // 当前选中设备

    DevicesModel{id: devicesModel}                  //设备列表数据

    signal deviceSelected(var deviceData)           //选中设备的信号---参数为设备信息的json对象

    //设置背景色
    // Rectangle{
    //     anchors.fill: parent
    //     color: "transparent"    // "lightgray" for test
    // }
    //1. ListView 整体列表
    ListView{
        id: listView
        currentIndex: -1
        anchors.fill: parent
        anchors.topMargin: 8

        // 注: 不能在顶层ListView中设置margin, 因为 好友item需要贯穿整行的hover效果
        // anchors.leftMargin: 12
        // anchors.rightMargin: 12

        clip: true  //防止内容溢出

        model: devicesModel             //独立的model文件
        delegate: DeviceDelegate{       //独立的UI展示 delegate
            // 显式传递模型上下文
            // model: modelData  // 传递过滤后的数据项

            currentDevice: root.currentDevice   //当前选中的设备

            //某个设备被选中事件处理, 子组件中clicked函数传入device信息, 通过json对象传参
            onClicked: (data)=>{
                           // console.log("DeviceList onClicked device: ", JSON.stringify(data))
                           listView.currentIndex = data.index
                           root.deviceSelected(data)
                       }
        }
    }
}

