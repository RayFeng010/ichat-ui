import QtQuick
import QtQuick.Controls

//Pane主要用于为内容提供视觉结构和内边距
//内容分组与视觉分隔
//提供内边距(Padding)
//作为其他控件的容器 实现卡片式设计
Pane {
    id:root
    property alias color: back.color            //Pane的背景色
    property alias border :back.border          //Pane边框

    //背景样式
    background: Rectangle
    {
        id: back
        color: "#F5F5F5"
    }
}
