import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// fontAwesome 字体图标按钮
Item {
    id: root
    width: 28; height: 28 //父组件可传入修改
    property string iconCode: "\uf106"
    property int iconSize: 22

    property bool hovered: false

    // 颜色配置 --- 灰色背景--黑色字体; hover-蓝色字体
    property color normalColor: "black"
    property color hoverColor: "#0099FF"
    property color selectedColor: "#0099FF"

    property int index: -1
    property bool selected: false

    //被点击事件
    signal clicked(int index)

    //字体图标
    Text {
        id: iconText
        anchors.centerIn: parent
        text: iconCode
        color: {
            if(selected) return root.selectedColor
            return root.hovered ? root.hoverColor : root.normalColor
        }

        font {
            family: "FontAwesome"  // 必须与加载的字体名称一致
            pixelSize: iconSize
        }
    }

    //鼠标点击区域
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.clicked(index)
    }
}


