/****************************************************************************
**  气泡
****************************************************************************/
.import Qt.Singleton 1.0 as SING

var BubbleTailWitdh = 10        // 气泡尾巴
var BubbleRadius = 6
var BubbleTailHeight = 3

function drawBubble(context) {

    var bubbleTailY = container.height/2

    context.clearRect(0,0,container.width, container.height)
    context.beginPath()
    context.roundedRect(isSend ? 0 : BubbleTailWitdh, 0,
                        container.width - BubbleTailWitdh, container.height,
                        BubbleRadius, BubbleRadius);

    context.moveTo(isSend ? container.width - BubbleTailWitdh : BubbleTailWitdh, bubbleTailY - BubbleTailHeight);
    context.lineTo(isSend ? container.width : 0, bubbleTailY );
    context.lineTo(isSend ? container.width - BubbleTailWitdh : BubbleTailWitdh, bubbleTailY + BubbleTailHeight);
    context.closePath()
    context.fillStyle = isSend ? SING.SkinSingleton.skins[SING.AppCfg.skinIndex].popupColor  : "#22445566"
    context.fill()
}
//SING.SkinSingleton.skins[SING.AppCfg.skinIndex].popupColor
