import QtQuick

//聊天消息导航 model
ListModel{
    ListElement{
        code: 10010                       //好友 or 群 code
        name: "张无忌"                   //好友 or 群 名
        nickName: "无忌哥哥"             //昵称
        header: "images/little_boy_1.png"
        count: 10                       //分组中的数量
        lastMessage: "明天晚上19:00-20：00游泳，羽毛球"
        lastDateTime: "22:11:44"
        online: true
        groupChat: false
        mute: false
        messages: [
            ListElement{senderCode:10010; receiverCode: 10008; type: 0; message: "晚上好"; dateTime: "2025-05-28 22:10:09" },
            ListElement{senderCode:10008; receiverCode: 10010; type: 0; message: "今晚吃aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa的啥"; dateTime: "2025-05-28 22:11:09" },
            ListElement{senderCode:10010; receiverCode: 10008; type: 0; message: "回锅肉"; dateTime: "2025-05-28 22:11:11" },
            ListElement{senderCode:10008; receiverCode: 10010; type: 0; message: "明天早上想吃啥"; dateTime: "2025-05-28 22:11:18" },
            ListElement{senderCode:10010; receiverCode: 10008; type: 0; message: "混动吧"; dateTime: "2025-05-28 22:11:22" },
            ListElement{senderCode:10008; receiverCode: 10010; type: 0; message: "好，还是两份"; dateTime: "2025-05-28 22:11:33" },
            ListElement{senderCode:10010; receiverCode: 10008; type: 0; message: "明天晚上19:00-20：00游泳"; dateTime: "2025-05-28 22:11:44" }
        ]
    }
    ListElement{
        code: 10011
        name:"敏敏"                   //赵敏
        header: "images/little_girl_1.png"
        count: 32                       //分组中的数量
        online: false
        mute: true
        groupChat: true
        lastMessage: "下午2:00-3：00打羽毛球"
        lastDateTime: "05-28"
        messages: [
            ListElement{senderCode:10011; receiverCode: 10008; type: 0; message: "晚上好"; dateTime: "5-22" },
            ListElement{senderCode:10008; receiverCode: 10011; type: 0; message: "今晚吃的啥"; dateTime: "22:11:09" },
            ListElement{senderCode:10011; receiverCode: 10008; type: 0; message: "回锅肉"; dateTime: "22:11:11" },
            ListElement{senderCode:10008; receiverCode: 10011; type: 0; message: "明天早上想吃啥"; dateTime: "22:11:18" },
            ListElement{senderCode:10011; receiverCode: 10008; type: 0; message: "混动吧"; dateTime: "2025-05-28 22:11:22" },
            ListElement{senderCode:10008; receiverCode: 10011; type: 0; message: "好，还是两份"; dateTime: "2025-05-28 22:11:33" },
            ListElement{senderCode:10011; receiverCode: 10008; type: 0; message: "下午2:00-3：00打羽毛球"; dateTime: "2025-05-28 22:11:44" }
        ]
    }
    ListElement{
        code: 108
        name: "三丰"                      //师傅
        nickName: "太极始祖"             //昵称
        header: "images/panda.png"
        count: 113                      //分组中的数量
        online: true
        mute: false
        groupChat: true
        lastMessage: "记得晚上练太极"
        lastDateTime: "2024-05-28"
        messages: [
            ListElement{senderCode:10008; receiverCode: 10005; type: 0; message: "晚上好"; dateTime: "2025-05-28 15:10:09" },
            ListElement{senderCode:10005; receiverCode: 10008; type: 0; message: "今晚吃的啥"; dateTime: "2025-05-28 16:11:09" },
            ListElement{senderCode:10008; receiverCode: 10005; type: 0; message: "回锅肉"; dateTime: "2025-05-28 17:11:11" },
            ListElement{senderCode:10005; receiverCode: 10008; type: 0; message: "明天早上想吃啥"; dateTime: "2025-05-28 17:15:18" },
            ListElement{senderCode:10008; receiverCode: 10005; type: 0; message: "混动吧"; dateTime: "2025-05-28 17:22:22" },
            ListElement{senderCode:10005; receiverCode: 10008; type: 0; message: "好，还是两份"; dateTime: "2025-05-28 17:30:33" },
            ListElement{senderCode:10008; receiverCode: 10005; type: 0; message: "记得晚上练太极"; dateTime: "2025-05-28 18:12:44" }
        ]
    }
}
