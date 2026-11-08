import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtQuick.Layouts

// 搜索框 设置初始化宽高
//父组件可设置
Item {
    id: searchBox
    // width: 100; height: 30
    property alias bgColor: background.color

    //背景
    Rectangle{
        id: background
        anchors.fill: parent
        width: 100
        height: 30
        color: "#f5f5f5"
        border.color: textInput.activeFocus ? "#0099FF" : "#F5F5F5"
        border.width: 1
        radius: 5
    }

    //行布局: 搜索icon--搜索输入框/提示文字--清除按钮
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 5
        spacing: 10

        // 搜索字体图标
        Text {
            id: searchIcon
            verticalAlignment: Qt.AlignVCenter
            text: "\uf002"  //fa-search f002
            color: "gray"
            font {
                family: "FontAwesome"  // 必须与加载的字体名称一致
                // pixelSize: 16
            }
        }

        // 输入框
        TextField {
            id: textInput
            Layout.fillWidth: true
            verticalAlignment: Qt.AlignVCenter
            // font.pixelSize: 14
            placeholderText: qsTr("Search ...")
            color: "#333333"
            selectByMouse: true
            background: Rectangle {
                id: bg
                anchors.fill: parent
                color: "transparent"
            }

            // 回车键触发搜索
            onAccepted: {
                console.log("开始搜索:", text)
                // 这里添加你的搜索逻辑
            }
        }

        // 清除按钮
        IconButton {
            id: clearButton
            visible: textInput.text !== ""
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20
            Layout.rightMargin: 10
            //flat: true

            iconCode: "\uf00d"          // + 图标fa-times f00d
            // iconSize: 16
            iconColor: "#939393"        // qq的灰色图标 939393， 背景ACACAC

            onClicked: {
                textInput.clear()
            }
        }
    }
}
