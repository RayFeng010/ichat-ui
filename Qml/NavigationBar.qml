import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    color: "#EBEBEB"

    property int selectedIndex: 0
    signal itemSelected(int index)

    //渐变
    // gradient: Gradient {
    //     GradientStop {
    //         position: 0
    //         color: "#6058fb"
    //     }
    //     GradientStop {
    //         position: 1
    //         color: "#6482f0"
    //     }
    // }

    // 窗口拖动区域（仅空白处）
    MouseArea {
        anchors.fill: parent
        // onPressed: rootWindow.startSystemMove()
        onDoubleClicked: toggleMaximize() // 双击切换最大化
    }

    // 最大化/还原切换函数
    function toggleMaximize() {
        if (maximized === true) {
            showNormal()
            maximized = false
        } else {
            showMaximized()
            maximized = true
        }
        //playWindowEffect()
    }

    ColumnLayout {
        id: layout
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.bottomMargin: 20
        spacing: 10

        property int currentIndex: root.selectedIndex

        // 点击处理函数
        function handleItemClick(index) {
            console.log("NaviBar: clicked index:", index)
            currentIndex = index
            root.itemSelected(index) //发出信号, ChatWindow.qml处理
        }

        // 按钮列表
        NavigationButton {
            index: 0
            iconCode: "\uf2bc"
            text: "通信录"
            selected: layout.currentIndex === index
            onClicked: layout.handleItemClick(index)
        }

        NavigationButton {
            index: 1
            iconCode: "\uf0e5"
            text: "消息"
            selected: layout.currentIndex === index
            onClicked: layout.handleItemClick(index)
        }

        NavigationButton {
            index: 2
            iconCode: "\uf095"
            text: "呼叫"
            selected: layout.currentIndex === index
            onClicked: layout.handleItemClick(index)
        }

        NavigationButton {
            index: 3
            iconCode: "\uf013"
            text: "设置"
            selected: layout.currentIndex === index
            onClicked: layout.handleItemClick(index)
        }

        //spacer
        Item {
            id: spacer
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        NavigationButton {
            index: 4
            iconCode: "\uf2c0"  //fa-user-o f2c0
            text: "个人信息"
            selected: layout.currentIndex === index
            onClicked: layout.handleItemClick(index)
        }

        NavigationButton {
            index: 5
            iconCode: "\uf190"
            text: "Logout"
            selected: layout.currentIndex === index
            onClicked: layout.handleItemClick(index)
        }
    }
}
