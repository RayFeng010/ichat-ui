import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

// import RelaxControls 1.0

TextArea {
    id: textArea
    property int gifWidth: 28
    property int gifHeight: 28
    antialiasing: true

    color: "#0E0E0E"
    font.pixelSize: 14
    font.family: "Microsoft Yahei"
    wrapMode: Text.WrapAnywhere
    textFormat: TextEdit.RichText
    selectByMouse: true
    selectByKeyboard: true

    property int tmpWidth: 0
    property int tmpHeight: 0

    // RichTextHandler {
    //     id : textObject
    //     document: area.textDocument         //必须设置文档结构
    //     cursorStart: area.selectionStart
    //     cursorEnd: area.selectionEnd
    //     width: gifWidth
    //     height: gifHeight
    //     onNeedUpdate: {
    //         let alpha = area.color.a;
    //         area.color.a = alpha - 0.01;
    //         area.color.a = alpha;
    //     }
    // }

    function insertGif(gif) {
        // textObject.inset(gif);
    }

    function coding() {
        // console.log("send:",area.text);
        // return textObject.coding();
    }

    // function encoding(text) {
    //     return textObject.encoding(text)
    // }

    function debug() {
        return textObject.debug();  // 调试,打印文本内容
    }

    function encoding(text) {

    }

    Component.onCompleted: {
        parseAndDisplayRichText(msgText)
    }

    // 解析富文本并显示在TextArea中
    function parseAndDisplayRichText(content) {
        // 清空TextArea
        textArea.text = "";

        // 正确的方式 (Qt6)
        var cursor = textArea.textCursor;
        // cursor.movePosition(TextCursor.Start);

        // 状态变量：是否在<style>标签内
        var inStyleTag = false;

        // 使用正则表达式解析富文本
        var regex = /(<style[\s\S]*?<\/style>)|(<img[^>]+>)|([^<]+)|(<[^>]+>)/g;
        var match;

        while ((match = regex.exec(content)) !== null) {
            if (match[1]) {
                // 匹配到完整的<style>标签及其内容 - 直接跳过
                console.log("跳过样式标签: " + match[1].substring(0, 40) + "...");
                continue;
            }
            else if (match[2]) {
                // 处理图片标签
                var imgRegex = /src=['"]([^'"]+)['"]|width=['"]([^'"]+)['"]|height=['"]([^'"]+)['"]/g;
                var imgMatch;
                var imgSource = "";
                var imgWidth = 400;
                var imgHeight = 300;

                while ((imgMatch = imgRegex.exec(match[2])) !== null) {
                    if (imgMatch[1]) imgSource = imgSource || imgMatch[1];
                    if (imgMatch[2]) imgWidth = imgMatch[2] ? parseInt(imgMatch[2]) : imgWidth;
                    if (imgMatch[3]) imgHeight = imgMatch[3] ? parseInt(imgMatch[3]) : imgHeight;
                }

                // 插入图片
                if (imgSource) {
                    console.log("插入图片: " + imgSource);
                    insertImage(imgSource);
                }
            }
            else if (match[3]) {
                // 插入纯文本 - 检查是否在<style>标签内
                if (inStyleTag) {
                    console.log("跳过样式内容: " + match[3].substring(0, 40) + "...");
                    continue;
                }

                var textContent = match[3].trim();
                if (textContent) {
                    console.log("插入文本: " + textContent);
                    textArea.insert(textArea.cursorPosition, textContent);
                }
            }
            else if (match[4]) {
                // 处理其他标签 - 检查<style>标签状态
                var tag = match[4];
                if (tag.toLowerCase().startsWith("<style")) {
                    inStyleTag = true;
                    console.log("开始<style>标签");
                }
                else if (tag.toLowerCase().startsWith("</style>")) {
                    inStyleTag = false;
                    console.log("结束<style>标签");
                }
                else if (tag.toLowerCase().startsWith("<br")) {
                    // 处理换行标签
                    textArea.insert(textArea.cursorPosition, "<br>")
                }
            }
        }
    }

    // 插入图片到TextArea
    function insertImage(source) {
        const imageUrl =  source //"file://" + source
        const html = `<img src="${imageUrl}" style="max-width: 350px; max-height: 300px;" />`

        console.log("RichText insert image: "+ html)

        textArea.insert(textArea.cursorPosition, "<br>")
        textArea.insert(textArea.cursorPosition, html)
        textArea.insert(textArea.cursorPosition, "<br>")
    }
}
