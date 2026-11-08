#ifndef AUDIO_MANAGER__H
#define AUDIO_MANAGER__H

#include <QObject>
#include <QAudioDevice>
#include <QThread>
#include <QMediaDevices>
#include <QVariantMap>
#include <QQuickItem>

class AudioLevelWorker;
class AudioManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(QList<QAudioDevice> devices READ devices NOTIFY devicesChanged)
    QML_ELEMENT
    
public:
    explicit AudioManager(QObject *parent = nullptr);
    
    ~AudioManager();
    
    double volume() const { return _volume; }
    QList<QAudioDevice> devices() const { return _devices; }
    
    Q_INVOKABLE void startMonitoring(int deviceIndex);
    
    Q_INVOKABLE void stopMonitoring();
    
    Q_INVOKABLE QVariantMap deviceInfo(int index) const;

signals:
    void volumeChanged(double volume);
    void devicesChanged();
    void startMonitoringRequested(const QAudioDevice &device);
    void stopMonitoringRequested();

private slots:
    void setVolume(double volume);
    
    void updateDevices();

private:
    QThread *_workerThread = nullptr;
    AudioLevelWorker *_audioLevelWorker = nullptr;
    double _volume;
    QMediaDevices _mediaDevices;
    QList<QAudioDevice> _devices;
};

#endif // AUDIO_MANAGER__H
