import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

//鼠标按住可拖动窗口的Bar
Item{
    id: root
    width: 120; height: 70

    // 窗口拖动区域（仅空白处）
    MouseArea {
        anchors.fill: parent
        // onPressed: startSystemMove() //FramelessWindow已经支持了
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

    //搜索框 和 按钮: +
    Rectangle{
        id: rowSearch
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        width: parent.width;
        height: 30

        //这两项都有效, 用于测试
        // color: "green"
        //border.color: 'lightgray'

        RowLayout{
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.rightMargin: 15

            //搜索框
            SearchBox{
                height: rowSearch.height
                bgColor: "#f5f5f5"          //浅灰
                // color: "blue"
                Layout.fillWidth: true
            }

            //按钮 +: 加好友与加群
            IconButtonV2{
                width: rowSearch.height; height: rowSearch.height
                iconCode: "\uf067"          // 搜索图标
                iconColor: "#939393"        // qq的灰色图标 939393， 背景ACACAC
                bgColor: "#f5f5f5"
            }

            /*
            IconButton{
                // width: rowSearch.height; height: rowSearch.height
                iconCode: "\uf067"          // 搜索图标
                // iconSize: 18
                iconColor: "#939393"        // qq的灰色图标 939393， 背景ACACAC
                // onClicked: search()
            }*/
        }
    }
}
