import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import Qt5Compat.GraphicalEffects

Popup{
         id: emojiPopup
         signal selectEmoji(string emojiFile)
         // 设置水平位置
         enum HorizontalPosBase {
                  PosBaseToLeft,                 // popup位于目标水平左侧
                  PosBaseToHorizontalLeft,       // popup位于目标水平中心左侧对齐
                  PosBaseToHorizontal,           // popup位于目标水平中心
                  PosBaseToHorizontalRigh,       // popup位于目标水平中心右侧对齐
                  PosBaseToRight                 // popup位于目标水平右侧
         }
         // 垂直对齐方式
         enum VerticalPosBase {
                  TopAlign,                  // popup的顶部与目标进行对齐
                  VerticalAlign,             // popup与目标垂直对齐
                  BottomAlign,               // popup的底部与目标底部进行对齐

                  // 下面只有当 horizontalPosBase = PosBaseToHorizontalLeft | PosBaseToHorizontal | PosBaseToHorizontalRigh时使用
                  PosBaseToTop,              // popup的Y坐标位于目标的上面
                  PosBaseToBottom            // popup的Y坐标位于目标的下面
         }

         property int horizontalPosBase: EmojiPopup.PosBaseToHorizontal
         property int verticalPosBase: EmojiPopup.PosBaseToBottom

         property int backgroundRadius: 1       // popup圆边框
         property var backgroundColor: "#FFF"   // 背景色
         property int targetSpacing: 5         // popup与目标的间隔

         // 构建资源路径：可执行文件目录 + 资源相对路径
         property string emojiPath: "file:///" + applicationDirPath + "/MyApp/emoji/res/"

         modal: false
         dim: false

         parent: Overlay.overlay
         closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
         background: Rectangle {
                  id: back

                  color: backgroundColor
                  anchors.fill: parent
                  radius: backgroundRadius

                  implicitWidth: 420
                  implicitHeight: 240

                  layer.enabled: true
                  layer.effect: DropShadow {
                  }
         }


         // 内容
         Component {
                  id: _emojiDelegate
                  AnimatedImage {
                           id: block
                           width: _content.cellWidth; height: _content.cellHeight
                           source: folderModel.folder + fileName
                           playing: true
                           fillMode: Image.Pad

                           MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onPositionChanged: {
                                             _content.currentIndex = index
                                    }
                                    onClicked: {
                                             selectEmoji(folderModel.folder + fileName)
                                             emojiPopup.close();
                                    }
                           }
                  }
         }

         GridView {
                  id: _content
                  anchors.fill: parent
                  anchors.margins: 0
                  clip: true
                  model: folderModel
                  cellWidth: parent.width/11
                  cellHeight: cellWidth
                  delegate: _emojiDelegate
                  currentIndex: -1
                  highlight: Rectangle { color: "lightsteelblue";  radius: 5
                           x: _content.currentItem.x
                           y: _content.currentItem.y
                           width: _content.cellWidth; height: _content.cellHeight
                  }
                  highlightFollowsCurrentItem: false // 关闭平滑移动
                  ScrollBar.vertical: ScrollBar {
                           policy: size<1.0? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
                           parent: _content.parent
                           anchors.top: _content.top
                           anchors.left: _content.right
                           anchors.bottom: _content.bottom
                  }
         }

         //标签gif资源model
         FolderListModel {
                  id: folderModel
                  showDirs: false
                  nameFilters: ["*.gif"]
                  folder: emojiPath
         }

         property var myTarget
         function posOpen(target) {
                  myTarget = getGlobalPos(target);
                  updatePopupPos();
                  console.log(myTarget,x,y,width,height)
                  emojiPopup.open();
         }


         function updatePopupPos() {

                  switch (horizontalPosBase)
                  {
                  case EmojiPopup.PosBaseToLeft:     // popup位于目标水平左侧

                           x = myTarget.x - width - targetSpacing;
                           y = verticalPosBase === EmojiPopup.TopAlign ? myTarget.y :
                                                                         verticalPosBase === EmojiPopup.VerticalAlign ? myTarget.y + myTarget.height/2 - height/2 :
                                                                                                                        myTarget.y - height + myTarget.height

                           break;

                  case EmojiPopup.PosBaseToHorizontalLeft: // popup水平中间左侧
                           x = myTarget.x ;
                           y = verticalPosBase === EmojiPopup.PosBaseToTop ? myTarget.y - height - targetSpacing :
                                                                             verticalPosBase === EmojiPopup.PosBaseToBottom ? myTarget.y + myTarget.height + targetSpacing :
                                                                                                                              myTarget.y + myTarget.height + targetSpacing

                           break;

                  case EmojiPopup.PosBaseToHorizontal: // popup水平中间
                           x = myTarget.x + myTarget.width/2 - width/2;
                           y = verticalPosBase === EmojiPopup.PosBaseToTop ? myTarget.y - height - targetSpacing :
                                                                             verticalPosBase === EmojiPopup.PosBaseToBottom ? myTarget.y + myTarget.height + targetSpacing :
                                                                                                                              myTarget.y + myTarget.height + targetSpacing

                           break;

                  case EmojiPopup.PosBaseToHorizontalRigh: // popup水平中间右侧
                           x = myTarget.x + myTarget.width - width;
                           y = verticalPosBase === EmojiPopup.PosBaseToTop ? myTarget.y - height - targetSpacing :
                                                                             verticalPosBase === EmojiPopup.PosBaseToBottom ? myTarget.y + myTarget.height + targetSpacing :
                                                                                                                              myTarget.y + myTarget.height + targetSpacing

                           break;


                  case EmojiPopup.PosBaseToRight:   // popup位于目标水平右侧

                           x = myTarget.x + myTarget.width + targetSpacing;
                           y = verticalPosBase === EmojiPopup.TopAlign ? myTarget.y :
                                                                         verticalPosBase === EmojiPopup.VerticalAlign ? myTarget.y + myTarget.height/2 - height/2 :
                                                                                                                        myTarget.y - height + myTarget.height
                           break;
                  }

         }


         function getGlobalPos(targetObject) {
                  var positionX = 0
                  var positionY = 0
                  var obj = targetObject

                  /* 遍历所有的父窗口 */
                  while (obj != null) {
                           positionX += obj.x
                           positionY += obj.y

                           obj = obj.parent
                  }

                  return {"x": positionX, "y": positionY, "width": targetObject.width, "height": targetObject.height}
         }

         Component.onCompleted: {
                  //初始化表情包资源路径
                  // emojiPath = "file:///" + applicationDirPath + "/MyApp/emoji/res/"
                  console.log("emoji folder: "+folderModel.folder)
         }
}
