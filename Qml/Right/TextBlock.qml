import QtQuick
import QtQuick.Controls
import Qt.labs.platform as Platform
import RelaxControls 1.0

//文本块内容
Item {
    id: root
    property alias text: textArea.text
    property int gifWidth: 28
    property int gifHeight: 28

    signal contentChanged
    signal sendTextMessage(string message)
    // signal sendAudioMessage(string audioFileUrl)
    // signal sendFileMessage(string fileUrl)

    //富文本编辑框
    TextArea {
        id: textArea
        anchors.fill: parent
        anchors.margins: 5
        // wrapMode: TextArea.WrapAnywhere
        wrapMode: TextArea.Wrap
        textFormat: TextEdit.RichText  // 启用富文本支持
        background: null
        selectByMouse: true
        placeholderText: qsTr("Talk Something... [Ctrl + enter] send Message")
        font.pixelSize: 14

        onTextChanged: root.contentChanged()

        // 拖放图片插入, 文件则确认是否发送文件
        DropArea {
            anchors.fill: parent
            onEntered: (drag) => {
                           //判断是否可以接受拖拽的内容
                           console.log("drag event entered")
                           // drag.containsDrag = false
                           var foundImage=false
                           if(drag.hasUrls){
                               for (let i = 0; i < drag.urls.length; i++) {
                                   const filePath = drag.urls[i].toString().replace("file://", "")
                                   if (/\.(jpe?g|png|gif|bmp)$/i.test(filePath)) {
                                       console.log("drag event contain image file: "+filePath)
                                       foundImage = true
                                   }
                               }
                           }

                           if(foundImage){
                               //图片, 允许插入
                               drag.accept(Qt.CopyAction)
                           }
                           else{
                               //普通文件,  弹框确认是否发送文件 --todo
                               drag.accepted = false
                           }

                       }

            onDropped: (drop) => {
                           if (drop.hasUrls) {
                               for (let i = 0; i < drop.urls.length; i++) {
                                   // console.log("drop file url: "+drop.urls[i].toString())
                                   const filePath = drop.urls[i].toString().replace("file://", "")
                                   if (/\.(jpe?g|png|gif|bmp)$/i.test(filePath)) {
                                       // console.log("drop file: "+filePath)
                                       processImage(filePath)
                                   }
                               }
                           }
                       }
        }

        // 粘贴剪贴板支持
        Keys.onPressed: event => {
                            if ((event.modifiers & Qt.ControlModifier) && event.key === Qt.Key_V) {
                                //Ctrl+V 粘贴图片
                                pastClipboard()
                            }
                            else if((event.modifiers & Qt.ControlModifier) && (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)){
                                console.log("Ctrl + enter clicked, send message: "+textArea.text)
                                root.sendTextMessage(textArea.text)
                                textArea.text = ""
                            }
                        }
    }

    //粘贴剪贴板的数据
    function pastClipboard(){
        // console.log("Clipboard image url: "+ClipboardHelper.saveImageToTemp())
        if(clipboard.hasImage()){
            var imageUrl = clipboard.saveImageToTemp()
            console.log("ClipboardHelper image url: "+imageUrl)
            if (imageUrl) {
                const html = `<img src="${imageUrl}" width="80" height=auto" />`
                // const html = `<img src="file://${filePath}" style="max-height:40px; width:auto;"/>`
                textArea.insert(textArea.cursorPosition, html)
            }
        }
        else if (clipboard.hasText()) {
            console.log("ClipboardHelper text: "+clipboard.text)
            paste()
        }else{
            console.log("can not paste anything")
        }
    }

    //c++的剪贴板
    ClipboardHelper{
        id: clipboard
    }

    //插入图片
    function insertImage(imgTag){
        textArea.insert(textArea.cursorPosition, imgTag)
    }

    //c++的gif动画插入 --- todo 会崩溃, 暂时是用插入图片模式
    function insertGif(imgTag){
         textObject.insertGif(textArea.textDocument, imgTag)
    }

    // RichTextHandler {
    //     id : textObject
    //     document: textArea.textDocument
    //     cursorStart: textArea.selectionStart
    //     cursorEnd: textArea.selectionEnd
    //     width: gifWidth
    //     height: gifHeight
    //     onNeedUpdate: {
    //         let alpha = textArea.color.a;
    //         textArea.color.a = alpha - 0.01;
    //         textArea.color.a = alpha;
    //     }
    // }

    // 处理图片插入
    function processImage(filePath) {
        const imageUrl =  "file://" + filePath
        const html = `<img src="${imageUrl}" width="80" height=auto" />`
        // const html = `<img src="file://${filePath}" style="max-height:40px; width:auto;"/>`
        textArea.insert(textArea.cursorPosition, html)
    }
}
