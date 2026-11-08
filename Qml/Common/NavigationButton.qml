import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    height: 50
    width: 66

    property alias text: label.text
    property string iconCode
    property var iconSource
    property int index: -1
    property bool selected: false
    property bool hovered: false

    // signal clicked(int idx)    //按钮被点击事件上报父组件
    signal clicked()    //按钮被点击事件上报父组件

    // id: background
    // anchors.fill: parent
    // radius: 6
    // color: hovered || selected ? "#444" : "transparent"

    // 颜色配置 --- 蓝色背景--白色字体
    // property color normalColor: "lightgray"
    // property color hoverColor: "white"
    // property color selectedColor: "white"

    // 颜色配置 --- 灰色背景--黑色字体; hover-蓝色字体
    property color normalColor: "black"
    property color hoverColor: "#0099FF"
    property color selectedColor: "#0099FF"

    Column {
        anchors.fill: parent
        spacing: 3

        // 字体图标
        Text {
            id: textIcon
            anchors.horizontalCenter: parent.horizontalCenter
            text: iconCode
            color: {
                if(selected) return root.selectedColor
                return root.hovered ? root.hoverColor : root.normalColor
            }
            font {
                family: "FontAwesome"  // 必须与加载的字体名称一致
                pixelSize: 24
            }
        }

        Text {
            id: label

            anchors.horizontalCenter: parent.horizontalCenter
            text: ""
            color: {
                if(selected) return root.selectedColor
                return root.hovered ? root.hoverColor : root.normalColor
            }
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
        }
    }

    //鼠标区域
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: {
            console.log("Nav button clicked, index: "+root.index)
            root.clicked()
        }
    }
}

