import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// fontAwesome 字体图标按钮
Item {
    id: root
    // width: 60; height: 25 //父组件可传入修改

    property int index: -1
    property alias text: label.text
    property alias textSize: label.font.pixelSize
    property alias color: label.color

    property bool hovered: false
    required property bool selected

    // 颜色配置
    property color normalColor: "gray"                         //正常文本颜色
    property color hoverColor: Qt.lighter(normalColor, 0.6)         //hover文本颜色稍微深色一点
    property color selectedColor: "#0099FF" //"blue"                            //按钮被选中的文本颜色

    property color bgColor: "#F2F2F2"                               //按钮背景色: QQ亮灰色
    property color hoveredBgColor: Qt.lighter(bgColor, 0.9)         //未使用 --- hover背景色不改变
    property color selectedBgColor: "white"                         //选中状态背景色变为白色

    property int padding: 4        // 内边距
    property alias font: label.font // 暴露字体属性

    // 动态宽度 = 文本实际宽度 + 左右内边距
    width: label.implicitWidth + 2 * padding
    height: label.implicitHeight + 2 * padding


    //被点击事件
    signal clicked

    //背景色
    Rectangle{
        id: back
        anchors.fill: parent
        radius: 2
        color: {
            if(selected)
                return root.selectedBgColor

            return  root.bgColor
            // return root.hovered ? root.hoveredBgColor : root.bgColor
        }
        // border.color: Qt.lighter(color)
    }

    //字体图标
    Text {
        id: label
        anchors.centerIn: parent
        // anchors.leftMargin: 5
        // anchors.rightMargin: 5

        text: "\uf129"          //默认字体code fa-info: 字母i
        font.pixelSize: 14
        color: {
            if(selected) return root.selectedColor
            return root.hovered ? root.hoverColor : root.normalColor
        }
    }

    //鼠标点击区域
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.clicked()
    }
}


