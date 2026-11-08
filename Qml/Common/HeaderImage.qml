/****************************************************************************
**  头像控件
** Author   : 诺谦 https://www.cnblogs.com/lifexy/
** Create   : 2021-6-12
****************************************************************************/

import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
    id: container
    property alias headerUrl : _image.source
    property bool antialiasingValue : true
    radius: 5
    Image {
        id: _image
        anchors.fill:parent
        antialiasing: antialiasingValue
        fillMode: Image.PreserveAspectFit
        visible: false
        cache: false             // 取消缓存,避免文件内容改变后,无法刷新图片
    }
    Rectangle {
            id: _mask
            color: "black"
            anchors.fill: parent
            radius: container.radius
            visible: false
            antialiasing: true
    }
    OpacityMask {
        id:mask_image
        anchors.fill: container
        source: _image
        maskSource: _mask        // 将source使用icon的规则在icon上显示
        visible: true
        antialiasing: true
    }
}
