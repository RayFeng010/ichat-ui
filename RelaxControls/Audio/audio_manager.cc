#include "audio_manager.h"
#include "audio_level_worker.h"

#include <QMediaDevices>
#include <QThread>
#include <QVariantMap>

AudioManager::AudioManager(QObject *parent): QObject(parent), _volume(0.0)
{
    // 创建后台线程和工作对象
    _workerThread = new QThread(this);
    _audioLevelWorker = new AudioLevelWorker();
    _audioLevelWorker->moveToThread(_workerThread);

    // 连接信号
    connect(_audioLevelWorker, &AudioLevelWorker::volumeChanged, this, &AudioManager::setVolume);
    connect(this, &AudioManager::startMonitoringRequested, _audioLevelWorker, &AudioLevelWorker::startMonitoring);
    connect(this, &AudioManager::stopMonitoringRequested, _audioLevelWorker, &AudioLevelWorker::stopMonitoring);

    // 启动线程
    _workerThread->start();

    // 初始设备列表
    updateDevices();

    // 监听设备变化
    connect(&_mediaDevices, &QMediaDevices::audioInputsChanged, this, &AudioManager::updateDevices);
}

AudioManager::~AudioManager() {
    _workerThread->quit();
    _workerThread->wait();
    delete _audioLevelWorker;
}

void AudioManager::startMonitoring(int deviceIndex) {
    qDebug() << "AudioManager start deviceIndex: " << deviceIndex << ", device size: " << _devices.size();

    if (deviceIndex >= 0 && deviceIndex < _devices.size()) {
        emit startMonitoringRequested(_devices[deviceIndex]);
    }
}

void AudioManager::stopMonitoring()
{
    emit stopMonitoringRequested();
}

QVariantMap AudioManager::deviceInfo(int index) const
{
    QVariantMap info;
    if (index >= 0 && index < _devices.size()) {
        const QAudioDevice &device = _devices[index];
        info["description"] = device.description();
        info["id"] = device.id();
        info["isDefault"] = device.isDefault();
    }
    return info;
}

void AudioManager::setVolume(double volume)
{
    // qDebug() << "AudioManager set volume: " << volume;
    if (qAbs(_volume - volume) > 0.01) {
        _volume = volume;
        emit volumeChanged(volume);
    }
}

void AudioManager::updateDevices() {
    _devices = QMediaDevices::audioInputs();
    emit devicesChanged();
}
