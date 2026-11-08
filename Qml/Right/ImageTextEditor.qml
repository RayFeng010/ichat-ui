import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// 编辑器组件
Item {
    id: root
    property alias textLength: contentArea.textLength
    property alias imageCount: contentArea.imageCount
    // activeFocus: contentArea.activeFocus //read only

    signal sendTextMessage(string textMessage)

    // 存储所有GIF组件
    property var gifComponents: ({})

    // 插入图片
    function insertImage(source) {
        contentArea.insertImage(source);
    }

    // 插入图片
    function insertGif(source) {
        // textEditor.insertGif(source);
        contentArea.insertImage(source);
    }

    // 粘贴内容
    function pasteContent() {
        contentArea.pasteContent();
    }

    // 清空内容
    function clear() {
        contentArea.clear();
    }

    // 编辑器内容区域
    Rectangle {
        id: editorContainer
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        color: "#F2F2F2"
        // border.color: contentArea.activeFocus ? "#3498db" : "#bdc3c7"
        // border.width: 2
        // radius: 8

        Flickable {
            id: flickable
            contentWidth: contentArea.width
            contentHeight: contentArea.height
            boundsBehavior: Flickable.StopAtBounds

            // 文本编辑器组件
            TextBlock {
                id: textEditor
                width: editorContainer.width
                height: editorContainer.height
                // onContentChanged: {
                //     console.log("TextBlock content: "+textEditor.text)
                // }
                onSendTextMessage: (textMessage) => root.sendTextMessage(textMessage)
            }

            // 内容区域
            Flow {
                id: contentArea
                width: editorContainer.width
                spacing: 5

                property int textLength: 0
                property int imageCount: 0

                // 计算文本长度
                function updateTextLength() {
                    var count = 0;
                    for (var i = 0; i < children.length; i++) {
                        if (children[i].isTextBlock) {
                            count += children[i].text.length;
                        }
                    }
                    textLength = count;
                }

                // 计算图片数量
                function updateImageCount() {
                    var count = 0;
                    for (var i = 0; i < children.length; i++) {
                        if (children[i].isImageBlock) {
                            count++;
                        }
                    }
                    imageCount = count;
                }

                // 插入图片
                function insertImage(source) {
                    // 构建HTML图片标签
                    const imgTag = `<img src="${source}" width="80" height=auto" />`
                    textEditor.insertImage(imgTag)
                    updateImageCount();
                }

                // 粘贴内容
                function pasteContent() {
                    if (Qt.clipboard.hasText) {
                        var text = Qt.clipboard.text;
                        var component = Qt.createComponent("TextBlock.qml");
                        if (component.status === Component.Ready) {
                            var textBlock = component.createObject(contentArea);
                            textBlock.text = text;
                            textBlock.onTextChanged.connect(updateTextLength);
                            updateTextLength();
                        }
                    } else if (Qt.clipboard.hasImage) {
                        var image = Qt.clipboard.image;
                        // 实际应用中应使用C++将QImage转换为Base64或保存为文件
                        var base64 = mainWindow.imageToBase64(image);
                        insertImage(base64);
                    }
                }

                // 清空内容
                function clear() {
                    while (children.length > 0) {
                        children[0].destroy();
                    }
                    textLength = 0;
                    imageCount = 0;
                }

                // 初始文本块
                Component.onCompleted: {
                    // var component = Qt.createComponent("TextBlock.qml");
                    // if (component.status === Component.Ready) {
                    //     var textBlock = component.createObject(contentArea);
                    //     textBlock.onTextChanged.connect(updateTextLength);
                    // }
                }
            }

        }
    }
}
