import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    width: 120; height: 35

    // property alias text: label.text
    property bool hovered: false
    property int currentIndex: 0        //用于确定当前选中的是哪个分组: 好友分组/群/设备

    signal itemSelected(int index)      //选中某个tab选项

    // 点击处理函数
    function handleButtonClick(index) {
        // console.log("Group witch buttons: clicked index:", index)
        currentIndex = index
        root.itemSelected(index) //发出信号, 父组件根据此信号处理 列表切换
    }

    Rectangle{
        anchors.fill: parent
        color: "#F2F2F2"

        RowLayout{
            id: rowBtns
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            // spacing: 0

            //好友按钮
            TextButton{
                index: 0
                text: qsTr("Friends")
                selected: currentIndex === index
                onClicked: root.handleButtonClick(index)
            }
            //好友按钮
            TextButton{
                index: 1
                text: qsTr("Groups")
                selected: currentIndex === index
                onClicked: root.handleButtonClick(index)
            }
            //好友按钮
            TextButton{
                index: 2
                text: qsTr("Devices")
                selected: currentIndex === index
                onClicked: root.handleButtonClick(index)
            }
        }
    }
}
