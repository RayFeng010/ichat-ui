import QtQuick

//设备列表 model
ListModel{
    ListElement{
        groupId: 101
        deviceId: "112"                 //设备id
        name: "Home-PC"                 //家里台式机
        header: "images/windows.png"
        count: 10                       //分组中的数量
        online: true
        os: "windows"; cpu: "8 cores"; harddisk: "2T"; network: "1000Mbps/s"; memory: "32GB"; display: "intel 8GB"
    }
    ListElement{
        groupId: 102
        deviceId: "113"                 //设备id
        name:"Home-Laptop"              //家里笔记本
        header: "images/linux.png"
        count: 32                       //分组中的数量
        online: false
        os: "linux"; cpu: "16 cores"; harddisk: "4T"; network: "1000Mbps/s"; memory: "64GB"; display: "NVIDIA RTX3060"
    }
    ListElement{
        groupId: 1001
        deviceId: "113"                 //设备id
        name: "Work-PC"                 //工作台式机
        header: "images/android.png"
        count: 113                      //分组中的数量
        online: true
        os: "android"; cpu: "24 cores"; harddisk: "8T"; network: "1000Mbps/s"; memory: "128GB"; display: "NVIDIA RTX2060"
    }
}
