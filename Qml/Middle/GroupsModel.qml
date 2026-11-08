import QtQuick


//2. 群分组 和 分组中的群列表 model: 我创建的群, 我加入的群，我管理的群
ListModel{
    ListElement{
        groupId: 101
        name: qsTr("My Groups")    //我创建的群
        expanded: true
        count: 10    //分组中的数量
        groups: [
            ListElement {groupId: 101; code: 11000; name: "项目一部"; phone: "13800138000"; header: "images/pinwheel.png"; owner: 11000;
                nickName: "chris"; remark: "Software technology"; description: "Software is everwhere"; category: 101; bulletin: "本周末聚会"
            },
            ListElement {groupId: 101; code: 11001; name: "项目一部"; phone: "13800138001"; header: "images/rocket.png"; owner: 11002;
                nickName: "chris"; remark: "人形机器人"; description: "未来3年的爆款机器人"; category: 101; bulletin: "每年参加机器人拳击比赛"
            }
        ]
    }
    ListElement{
        groupId: 102
        name: qsTr("Joined Groups")  //我加入的群
        expanded: false
        count: 32    //分组中的数量
        groups: [
            ListElement {groupId: 102; code: 11002; name: "国内销售"; header: "images/bubble.png"; owner: 11004;
                nickName: "chris"; remark: "争取各大区销售增长30%"; description: "只允许讨论工作相关的内容"; category: 101; bulletin: "本周末聚会"
            },
            ListElement {groupId: 102; code: 11003; name: "移动项目"; phone: "13800138003"; header: "images/spaceship.png"; owner: 11005;
                nickName: "chris"; remark: "移动项目群"; description: "5G is on"; category: 101; bulletin: "本周末聚会"
            },
            ListElement {groupId: 102; code: 11004; name: "中东市场"; phone: "13800138004"; header: "images/fire1.png"; owner: 11006;
                nickName: "chris"; remark: "中东非洲区域"; description: "增长超50%"; category: 101; bulletin: "本周末聚会"
            }
        ]
    }
    ListElement{
        groupId: 1001
        name: qsTr("Managed Groups")  //我管理的群
        expanded: false
        count: 113    //分组中的数量
        groups: [
            ListElement {groupId: 1001; code: 11005; name: "架构组"; phone: "13800138002"; header: "images/firefox.png"; owner: 11007;
                nickName: "chris"; remark: "架构合理更重要"; description: "跟踪业界先进技术"; category: 101; bulletin: "本周末聚会"
            },
            ListElement {groupId: 1001; code: 11006;  name: "质量部"; phone: "13800138003"; header: "images/msn.png"; owner: 11008;
                nickName: "chris"; remark: "追求性能极致, 稳定第一"; description: "你的好帮手"; category: 101; bulletin: "本周末聚会"
            },
            ListElement {groupId: 1001; code: 11007; name: "性能分析交流"; phone: "13800138004"; header: "images/qq.png"; owner: 11009;
            nickName: "chris"; remark: "追求性能极致, 从代码, 架构, 硬件多维度优化"; description: "性能没有最优, 只有更优"; category: 101; bulletin: "本周末聚会"
            }
        ]
    }
}
