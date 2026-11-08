import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


// fontAwesome 字体图标按钮
ToolButton {
    property alias iconCode: iconText.text
    property alias iconSize: iconText.font.pixelSize
    property alias iconColor: iconText.color
    // property alias bgColor: back.color
    // width: 25; height: 25 //父组件传入, 不生效 why

    //不能设置背景色, 否则没有hover效果了
    // background: Rectangle{
    //     id: back
    //     anchors.fill: parent
    //     color: "#f5f5f5"
    // }

    Label {
        id: iconText
        anchors.centerIn: parent
        text: "\uf129"          //默认字体code fa-info: 字母i

        font {
            family: "FontAwesome"  // 必须与加载的字体名称一致
            pixelSize: 14
        }
    }
}


