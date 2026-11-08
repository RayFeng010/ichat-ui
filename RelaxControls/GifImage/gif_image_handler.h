// GifImageProvider.h
#include <QQuickImageProvider>
#include <QMovie>
#include <QMap>
#include <QImage>

class GifImageProvider : public QQuickImageProvider {
public:
    GifImageProvider();

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

private:
    QMap<QString, QMovie*> movies;
};
