import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// fontAwesome 字体图标按钮
Item {
    id: root
    width: 25; height: 25 //父组件可传入修改

    property alias iconCode: iconText.text
    property alias iconSize: iconText.font.pixelSize
    property alias iconColor: iconText.color

    property bool hovered: false
    property color bgColor: "#F5F5F5"
    property color hoveredBgColor: Qt.lighter(bgColor, 0.9)

    //被点击事件
    signal clicked

    //背景色
    Rectangle{
        id: back
        anchors.fill: parent
        radius: 5
        color: root.hovered ? hoveredBgColor:bgColor
        border.color: Qt.lighter(color)
    }

    //字体图标
    Label {
        id: iconText
        anchors.centerIn: parent
        text: "\uf129"          //默认字体code fa-info: 字母i

        font {
            family: "FontAwesome"  // 必须与加载的字体名称一致
            pixelSize: 14
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


