import QtQuick


//好友分组model 和 分组中的好友列表
//注: 上面两个目前定义到一个ListModel中, 分别定义目前还未实现
ListModel{
    ListElement{
        groupId: 101
        name: qsTr("My Home")       //我的家人
        count: 10    //分组中的数量
        friends: [
            ListElement {groupId: 101; userName: "聆码息"; phone: "13800138000"; header: "images/man.png"; gender: "Male"; city: "shenzhen China";
                nickName: "Rayfeng"; remark: "Software engneer"; signature: "Code Whisper"; online: true; code: 10002; birthday: "1986-06-08"
            },
            ListElement {groupId: 101;  userName: "小甜甜"; phone: "13800138001"; header: "images/woman.png"; gender: "Female"; city: "shenzhen China";
                nickName: "tangtang"; remark: "Architecture engneer"; signature: "Calculation everyday"; online: true; code: 10003; birthday: "1989-09-09"
            },
            ListElement {groupId: 101;  userName: "游戏人生"; phone: "13800138001"; header: "images/young_boy2.png"; gender: "Male"; city: "shenzhen China";
                nickName: "nemo"; remark: "Game lover"; signature: "Top 10 player all over the country"; online: true; code: 10004; birthday: "2007-01-18"
            },
            ListElement {groupId: 101;  userName: "无剂"; phone: "13800138001"; header: "images/young_boy3.png"; gender: "Male"; city: "shenzhen China";
                nickName: "tailang"; remark: "软件开发 爱好者"; signature: "Happy everyday"; online: true; code: 10025; birthday: "2012-09-11"
            }
        ]
    }
    ListElement{
        groupId: 102
        name: qsTr("Middle School")  //中学
        count: 32    //分组中的数量
        friends: [
            ListElement {groupId: 102;  userName: "三丰"; phone: "13800138002"; header: "images/panda.png"; gender: "Male"; city: "guiyang China";
            nickName: "kongfu"; remark: "Playing football"; signature: "玩克"; online: true; code: 10005; birthday: "1966-05-05"
            },
            ListElement {groupId: 102;  userName: "李思"; phone: "13800138003"; header: "images/little_girl.png"; gender: "Male"; city: "wuhan China";
            nickName: "lisi"; remark: "Ping Pong lover"; signature: "Champion Asia"; online: true; code: 10006; birthday: "1992-02-02"
            },
            ListElement {groupId: 102;  userName: "王五"; phone: "13800138004"; header: "images/little_girl_1.png"; gender: "Male"; city: "shanghai China";
            nickName: "wangwu"; remark: "Stock researcher"; signature: "1 million USD"; online: true; code: 10007; birthday: "1982-07-09"
            }
        ]
    }
    ListElement{
        groupId: 1001
        name: "一村"  //我加入的分组
        count: 113    //分组中的数量
        friends: [
            ListElement {groupId: 1001;  userName: "黄蓉"; phone: "13800138002"; header: "images/little_girl.png"; gender: "Male"; city: "beijing China";
            nickName: "huangrong"; remark: "丐帮帮主"; signature: "喜欢美食"; online: true; code: 10008; birthday: "1988-08-06"
            },
            ListElement {groupId: 1001;  userName: "郭靖"; phone: "13800138003"; header: "images/young_boy2.png"; gender: "Male"; city: "chengdu China";
            nickName: "靖哥哥"; remark: "天下第一"; signature: "天天搬砖"; online: true; code: 10009; birthday: "1996-03-02"
            },
            ListElement {groupId: 1001;  userName: "张无忌"; phone: "13800138004"; header: "images/young_boy.png"; gender: "Male"; city: "guangzhou China";
            nickName: "无忌"; remark: "九阳神功"; signature: "迎娶美女"; online: true; code: 10010; birthday: "1976-09-18"
            },
            ListElement {groupId: 1001;  userName: "敏敏"; phone: "13800138004"; header: "images/little_girl_1.png"; gender: "Female"; city: "guangzhou China";
            nickName: "无忌"; remark: "九阳神功"; signature: "心旺无忌"; online: true; code: 10011; birthday: "1976-09-18"
            }
        ]
    }
}

