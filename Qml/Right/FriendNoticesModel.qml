import QtQuick


//好友通知数据 model
ListModel{
    ListElement{
        initiatorId: 101
        initiatorCode: 10008
        initiatorNickName: "黄蓉"
        inviteeId:102
        inviteeCode: 10002
        inviteeNickName: "chris"
        header: "images/man.png"
        message: "Here is wonderful"
        dateTimeString: "2025-05-30T19:31:32"
        inviteStatus: 1         // 1: 等待对方验证; 2: 对方已经同意; 3: 对方已经拒绝
        readStatus: false       //被邀请者读取通知的状态

    }
    ListElement{
        initiatorId: 101
        initiatorCode: 10008
        initiatorNickName: "黄蓉"
        inviteeId:103
        inviteeCode: 10003
        inviteeNickName: "tangtang"
        header: "images/woman.png"
        message: "你的笑容格外灿烂"
        dateTimeString: "2025-05-10T06:21:32"
        inviteStatus: 1         // 1: 等待对方验证; 2: 对方已经同意; 3: 对方已经拒绝
        readStatus: false       //被邀请者读取通知的状态
    }
    ListElement{
        initiatorId: 101
        initiatorCode: 10008
        initiatorNickName: "黄蓉"
        inviteeId:104
        inviteeCode: 10025
        inviteeNickName: "leo"
        header: "images/young_boy3.png"
        message: "每天都是新的开始"
        dateTimeString: "2024-05-30T11:31:32"
        inviteStatus: 1         // 1: 等待对方验证; 2: 对方已经同意; 3: 对方已经拒绝
        readStatus: false       //被邀请者读取通知的状态
    }
    ListElement{
        initiatorId: 101
        initiatorCode: 10008
        initiatorNickName: "黄蓉"
        inviteeId:104
        inviteeCode: 10004
        inviteeNickName: "林远"
        header: "images/young_boy2.png"
        message: "每天都是新的开始"
        dateTimeString: "2024-06-20T11:31:32"
        inviteStatus: 1         // 1: 等待对方验证; 2: 对方已经同意; 3: 对方已经拒绝
        readStatus: false       //被邀请者读取通知的状态
    }
    ListElement{
        initiatorId: 101
        initiatorCode: 10005
        initiatorNickName: "熊猫大侠"
        inviteeId:104
        inviteeCode: 10008
        inviteeNickName: "黄蓉"
        header: "images/panda.png"
        message: "每天都是新的开始"
        dateTimeString: "2025-06-02T11:31:32"
        inviteStatus: 1         // 1: 等待对方验证; 2: 对方已经同意; 3: 对方已经拒绝
        readStatus: false       //被邀请者读取通知的状态
    }
}

