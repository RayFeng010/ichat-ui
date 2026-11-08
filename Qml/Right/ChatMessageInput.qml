import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window as QuickWindow
import Qt.labs.platform as Platform
import QtCore          // 用于访问QUrl和QImage

//聊天消息List
Item{
    id: root
    // color: "#F2F2F2"  //for test "yellow"

    property int index: -1

    signal sendTextMessage(string textMessage)

    //纵向布局: 1. 上面为工具条; 2. 下面为输入框
    ColumnLayout{
        id: chatInputLayout
        anchors.fill: parent
        spacing: 0

        //1. 工具条
        RowLayout{
            id: chatInputBar
            Layout.fillWidth: true
            Layout.preferredHeight: 30
            Layout.leftMargin: 12
            Layout.rightMargin: 12
            spacing: 12

            property int currentIndex: -1

            // 点击处理函数
            function handleItemClick(index) {
                console.log("ChatInputBar: clicked index:", index)
                currentIndex = index
                // root.itemSelected(index) //发出信号, ChatWindow.qml处理
            }

            //表情
            IconButtonV3{
                id: emoji
                index: 0
                iconCode: "\uf118"      //fa-smile-o f118
                // selected: chatInputBar.currentIndex === index
                onClicked: (data)=>{
                               parent.handleItemClick(data)
                               emoji_popup.posOpen(emoji)
                           }
            }

            //发送图片
            IconButtonV3{
                index: 1
                iconCode: "\uf03e"      //fa-image-o f03e
                // selected: chatInputBar.currentIndex === index
                onClicked: (data)=>{
                               parent.handleItemClick(data)
                               //如果是图片插入图片, 如果不是图片, 显示文件图标
                               insertImageFile()
                           }

            }

            //发送文件
            IconButtonV3{
                index: 2
                iconCode: "\uf016"      //fa-file-o f016
                // selected: chatInputBar.currentIndex === index
                onClicked: (data)=>{
                               parent.handleItemClick(data)
                               //如果是图片插入图片, 如果不是图片, 显示文件图标
                               insertOtherFile()
                           }

            }

            //发送语音
            IconButtonV3{
                index: 3
                iconCode: "\uf130"      //fa-microphone-o f130
                // selected: chatInputBar.currentIndex === index
                onClicked: (data)=>{
                               parent.handleItemClick(data)
                               recordDialog.open()
                           }
            }

            //中间弹簧
            Item {
                Layout.fillWidth: true
            }

            //历史消息
            IconButtonV3{
                index: 3
                iconCode: "\uf017"      //fa-clock f017
                // selected: chatInputBar.currentIndex === index
                onClicked: (data)=>{
                               parent.handleItemClick(data)
                           }
            }

        }

        //2. 输入框
        ImageTextEditor{
            id:editor
            Layout.fillWidth: true
            Layout.fillHeight: true

            //发送文本消息
            onSendTextMessage: (textMessage) => root.sendTextMessage(textMessage)
        }

        //3. 状态栏
        // Text {
        //     height: 30
        //     text: `字符数: ${editor.textLength} | 图片数: ${editor.imageCount}`
        //     color: "#7f8c8d"
        //     font.pixelSize: 12
        // }
    }


    //插入文件
    function insertImageFile(){
        imageFileDialog.open()
    }


    // 检查URL是否为图片
    function isImageUrl(url) {
        var urlStr = url.toString().toLowerCase()
        return urlStr.endsWith('.png') ||
                urlStr.endsWith('.jpg') ||
                urlStr.endsWith('.jpeg') ||
                urlStr.endsWith('.bmp') ||
                urlStr.endsWith('.gif')
    }

    // 图片选择对话框
    Platform.FileDialog {
        id: imageFileDialog
        title: "选择图片"
        // folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
        onAccepted: {
            for (var i = 0; i < files.length; i++) {
                if(isImageUrl(files[i]))
                    editor.insertImage(getImageUrl(files[i]));
            }
        }
    }

    // 修复路径问题：正确处理文件路径
    function getImageUrl(path) {
        // 如果是Windows路径，处理反斜杠
        if (Qt.platform.os === "windows") {
            // 替换反斜杠
            return path.toString().replace(/\\/g, "/");
        }
        // Linux/Mac路径
        return path;
    }

    //插入文件
    function insertOtherFile(){
        otherFileDialog.open()
    }

    // 图片选择对话框
    Platform.FileDialog {
        id: otherFileDialog
        title: "选择非图片文件"
        // folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        nameFilters: ["Files (*.*)"]
        // onAccepted: insertImage(fileDialog.currentFile)
    }

    //录音对话框
    RecordDialog{
        id: recordDialog
        x: chatInputLayout.x; y: chatInputLayout.y
        width: chatInputLayout.width; height: chatInputLayout.height
        title: qsTr("Record audio")
        visible: false
        onCancleRecord: {
            console.log("recordDialog close record clicked")
            recordDialog.close()
            rootWindow.message("sucess", "close record dialog")
        }
        onSendAudio: (fileUrl)=>{
                         console.log("recordDialog send audio clicked, file: "+fileUrl)
                         recordDialog.close()
                         rootWindow.message("sucess", "send audio ok")
                     }
    }

    EmojiPopup {
       id: emoji_popup
       horizontalPosBase: EmojiPopup.PosBaseToHorizontalLeft
       verticalPosBase: EmojiPopup.PosBaseToTop

       onSelectEmoji: (emojiFile) => editor.insertGif(emojiFile)
    }

}

