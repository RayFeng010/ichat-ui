#ifndef AudioLevelWorker_H
#define AudioLevelWorker_H

#include <QObject>
#include <QAudioSource>
#include <QAudioDevice>
#include <QIODevice>

class AudioLevelWorker : public QObject
{
    Q_OBJECT
public:
    explicit AudioLevelWorker(QObject *parent = nullptr);
    ~AudioLevelWorker();

public slots:
    void startMonitoring(const QAudioDevice &device);

    void stopMonitoring();

signals:
    void volumeChanged(double volume);

private slots:
    void processAudio();

private:
    QAudioSource *_audioSource;
    QIODevice *_audioIO;
};

#endif // AudioLevelWorker_H
