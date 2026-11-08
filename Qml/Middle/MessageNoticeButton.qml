import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    width: 120; height: 35

    property alias text: label.text
    property bool hovered: false

    signal clicked

    Rectangle{
        anchors.fill: parent
        color: hovered?"#F2F2F2":"white" //#F5F5F5

        RowLayout{
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12

            //按钮文字
            Text {
                id: label
                text: qsTr("text")
                font.pixelSize: 14
            }

            //图标靠右
            Text {
                Layout.alignment: Qt.AlignRight
                text: "\uf105"  //fa-arror-right f061; fa-angle-right f105

                font {
                    family: "FontAwesome"  // 必须与加载的字体名称一致
                    pixelSize: 16
                }
            }
        }

        //鼠标点击事件/hover
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: root.hovered = true
            onExited: root.hovered = false
            onClicked: root.clicked()
        }
    }
}
