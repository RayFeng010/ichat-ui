import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 图片块组件
Item {
    id: imageBlock
    property alias source: image.source
    property bool isImageBlock: true
    property alias imageWidth: imageBlock.width
    property alias imageHeight: imageBlock.height
    
    width: image.width
    height: 80

    property int minImageLength: 40
    property int maxImageLength: 80

    Image {
        id: image
        width: height * (sourceSize.width / sourceSize.height)
        height: 80
        fillMode: Image.PreserveAspectFit
        asynchronous: true
    }
    
    // // 删除按钮
    // Text {
    //     width: 16
    //     height: 16
    //     text: "\uf00d"      //fa-times x
    //     anchors.right: parent.right
    //     anchors.top: parent.top
    //     anchors.margins: 2
    //     font {
    //         family: "FontAwesome"  // 必须与加载的字体名称一致
    //         pixelSize: 18
    //     }

    //     MouseArea {
    //         anchors.fill: parent
    //         onClicked: imageBlock.deleteRequested()
    //     }
    // }
    
    // 拖放支持
    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2
    
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        acceptedButtons: Qt.LeftButton
        
        onPressed: {
            parent.grabToImage(function(result) {
                parent.Drag.imageSource = result.url;
            },
            { targetSize: Qt.size(100, 100) })
        }
    }
    
    signal deleteRequested()
}
