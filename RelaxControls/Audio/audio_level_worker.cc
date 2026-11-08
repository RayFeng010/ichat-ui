#include "audio_level_worker.h"

#include <QAudioFormat>
#include <QThread>
#include <QDebug>
#include <cmath>

AudioLevelWorker::AudioLevelWorker(QObject *parent )
    : QObject(parent), _audioSource(nullptr), _audioIO(nullptr) {}

AudioLevelWorker::~AudioLevelWorker() {
    stopMonitoring();
}


void AudioLevelWorker::startMonitoring(const QAudioDevice &device)
{
    stopMonitoring();

    // 设置音频格式
    QAudioFormat format;
    format.setSampleRate(8000);  // 8kHz 采样率
    format.setChannelCount(1);   // 单声道
    format.setSampleFormat(QAudioFormat::Int16); // 16位整型

    // 检查设备是否支持该格式
    if (!device.isFormatSupported(format)) {
        qWarning() << "Default format not supported, trying to use the nearest.";
        format = device.preferredFormat();
    }

    // 创建音频输入对象
    _audioSource = new QAudioSource(device, format, this);
    _audioIO = _audioSource->start();

    // 连接数据可读信号
    connect(_audioIO, &QIODevice::readyRead, this, &AudioLevelWorker::processAudio);
}

void AudioLevelWorker::stopMonitoring() {
    if (_audioSource) {
        _audioSource->stop();
        disconnect(_audioIO, &QIODevice::readyRead, this, &AudioLevelWorker::processAudio);
        delete _audioSource;
        _audioSource = nullptr;
        _audioIO = nullptr;
    }
}

void AudioLevelWorker::processAudio() {
    if (!_audioIO) return;

    QByteArray data = _audioIO->readAll();
    if (data.isEmpty()) return;

    // 计算音量 (RMS)
    double sum = 0.0;
    const int16_t *samples = reinterpret_cast<const int16_t*>(data.constData());
    int sampleCount = data.size() / sizeof(int16_t);

    for (int i = 0; i < sampleCount; ++i) {
        double sample = samples[i] / 32768.0; // 归一化到 [-1, 1]
        sum += sample * sample;
    }

    double rms = sqrt(sum / sampleCount);
    double volume = qBound(0.0, rms, 1.0);

    emit volumeChanged(volume);
}
