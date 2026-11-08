import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Layouts
import QtCore
import QtQuick.Dialogs
import Qt.labs.platform as Platform
import RelaxControls 1.0

//录音对话框
Dialog {
    id: recordDialog
    modal: true
    title: "录音对话框"
    width: 350; // height: 400 // standardButtons: Dialog.Ok | Dialog.Cancel //自定义按钮
    onAccepted: {

    }
    onRejected: {
        console.log("recordDialog onRejected")
        if(started){
            audioManager.stopMonitoring()
            started = false
        }
    }

    //当前audioInput index
    property int audioInputIndex: 0

    // 存储当前音量级别
    property real volumeLevel: 0.0

    // 是否已经启动录音
    property bool started: false

    signal cancleRecord
    signal sendAudio(string url)

    //c++的音量监控 MediaDevices C++中给出音频mic列表
    AudioManager{
        id: audioManager
        onVolumeChanged: (db)=>{
                             // console.log("AudioManager volume changed: "+db)
                             volumeLevel = db
        }
    }

    // 创建捕获会话 QT6.6后通过CaptureSession连接audioInput
    CaptureSession {
        id: captureSession

        // 音频输入配置
        audioInput: AudioInput {
            id: audioInput
            device: audioManager.devices[0]
            volume: 0.8 // 在AudioInput内设置音量
            onDeviceChanged: {
                console.log("audioInput device changed: "+device.description)
            }
        }

        // 媒体录制器
        recorder: MediaRecorder {
            id: recorder
            quality: MediaRecorder.HighQuality
            outputLocation: getTempDir()+"/recording.mp3"
            audioSampleRate: 44100
            audioChannelCount: 1

            onRecorderStateChanged: {
                if (recorderState === MediaRecorder.StoppedState)
                    statusText.text = "Saved: " + outputLocation.toString()
                console.log("recorder state changed, mediaFormat: "+recorder.mediaFormat)
            }
        }
    }

    //整体横向布局
    RowLayout{
        anchors.fill: parent

        Item {  //弹簧
            Layout.fillWidth: true
        }

        IconButtonV3{   //左边: 开始录音图标
            width: 80; height: 80
            iconCode: started?"\uf0c8":"\uf130"      //fa-square f0c8 / fa-microphone-o f130
            iconSize: started?50:60
            normalColor: started?"#FF6C37":"#07c160"
            hoverColor: Qt.lighter(normalColor, 0.8)
            selectedColor: Qt.lighter(normalColor, 0.8)
            onClicked: {    //启动or停止录音
                if(started){
                    audioManager.stopMonitoring()
                    statusText.text = recorder.outputLocation
                }
                else{
                    audioManager.startMonitoring(audioInputIndex)
                    statusText.text = "Recording..."
                }

                started=!started
            }
        }

        //右边纵向布局, mic 输入/音量指示, 状态, 发送与关闭
        Column {
            width: 300
            spacing: 12

            // 麦克风选择下拉框
            ComboBox {
                id: micComboBox
                width: parent.width
                height: 25
                model: audioManager.devices
                textRole: "description"

                onActivated: {  // 切换设备时更新音频输入
                    console.log("ComboBox audioInput currentIndex changed: "+ micComboBox.currentIndex)
                    audioInput.device = micComboBox.currentValue;
                    audioInputIndex = micComboBox.currentIndex
                }
            }

            // 音量指示 Audio level visualization
            ProgressBar {
                id: volumeBar
                width: parent.width
                value:  volumeLevel

                //进度条
                Rectangle {
                    width: volumeBar.visualPosition * parent.width
                    height: parent.height  //; radius: 12
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "green" }
                        // GradientStop { position: 0.5; color: "#2980b9" }
                        GradientStop { position: 1.0; color: "#95EC69" }
                    }
                }
            }

            Text {
                id: statusText
                height: 25
                text: audioInput.device.description
                      ? "当前使用: " + audioInput.device.description
                      : "未选择麦克风"
            }

            // Record/Stop controls
            RowLayout {
                width: parent.width
                spacing: 20
                Item {
                    Layout.fillWidth: true
                }

                Button {    // 发送音频
                    text: qsTr("Send")
                    onClicked: {
                        statusText.text = ""
                        if(started){
                            audioManager.stopMonitoring()
                            started = false
                        }
                        recordDialog.sendAudio(recorder.outputLocation)
                    }
                }
                Button {    //关闭对话框
                    text: qsTr("Close")
                    onClicked: {
                        statusText.text = ""
                        if(started){
                            audioManager.stopMonitoring()
                            started = false
                        }

                        recordDialog.cancleRecord()
                    }
                }
                Item {
                    Layout.fillWidth: true
                }

            }

            Item {  //弹簧
                Layout.fillHeight: true
            }
        }

        Item {  //弹簧
            Layout.fillWidth: true
        }
    }

    // 获取临时目录路径
    function getTempDir(){
        var tempDir = Platform.StandardPaths.writableLocation(Platform.StandardPaths.TempLocation)
        console.log("user tmp dir: "+tempDir)
        return tempDir
    }
}
