// GifImageProvider.cpp
#include "GifImageProvider.h"

GifImageProvider::GifImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Image)
{}

QImage GifImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    if (!movies.contains(id)) {
        auto movie = new QMovie(":/images/" + id);
        movie->start();
        movies.insert(id, movie);
    }

    QMovie* movie = movies[id];
    if (movie && movie->isValid()) {
        QImage frame = movie->currentImage();
        if (size)
            *size = frame.size();
        return frame;
    }

    return QImage();
}
