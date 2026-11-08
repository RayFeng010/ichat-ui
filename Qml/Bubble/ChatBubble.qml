import QtQuick
import QtQuick.Controls

import "BubbleNormal.js" as BubbleNormal
import "BubbleBlue.js" as BubbleBlue
import "BubbleBlack.js" as BubbleBlack
import "BubbleBlueWhite.js" as BubbleBlueWhite

//有背景色的消息内容展示 --- 可以展示gif笑脸
RichText {
    id: container

    property string msgText: ""
    property bool isSend: true
    property int iconHeight: 40
    property int maxWidth: 0

    // textFormat: TextEdit.PlainText
    textFormat: TextEdit.RichText  // 启用富文本支持
    height: contentHeight+20
    Canvas {
        id: canvas
        parent: back
        anchors.fill: back
        onPaint: {
            bubble().drawBubble(getContext('2d'));
        }
    }

    //背景色
    background: Rectangle {
        id: back
        anchors.fill: parent
        color: "transparent"
    }
    z: 2
    MouseArea {
        anchors.fill: parent
        onClicked: {
            // debug();
            // Model.clipboard(coding());
            // rootWindow.message('success','复制文本成功!');
        }
    }

    Component.onCompleted: {
       encoding(msgText);   //重新编码消息, 宽度根据最大宽度动态调整
       width = contentWidth > maxWidth ? maxWidth : contentWidth+28

    }

    font.pixelSize: 15
    font.family: "Microsoft Yahei"
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter
    padding: 8
    leftPadding: isSend ? 8 : 20
    rightPadding: isSend ? 20 : 8
    readOnly: false
    color: isSend ? "#FFFFFF" : "#0E0E0E"


    function bubble() {
        return BubbleBlueWhite
        // switch (AppCfg.bubbleIndex) {
        //     case "0" :  return BubbleNormal
        //     case "1" :  return BubbleBlue
        //     case "2" :  return BubbleBlack
        //     default: return BubbleBlue
        // }
    }

}
