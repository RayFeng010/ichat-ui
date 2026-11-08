/****************************************************************************
**  Rich text 文本处理
** Author   : ChrisLee
** Des      : 将richText中的图标单独行显示, 重置宽高
** Create   : 2025-06-18
****************************************************************************/

#ifndef RICH_TEXT_HANDLER__H
#define RICH_TEXT_HANDLER__H

#include <QObject>
#include <QQuickTextDocument>
#include <QTextDocument>
#include <QHash>
#include <QMovie>
#include <QTimer>
#include <QImage>
#include <QSize>

class RichTextHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQuickTextDocument* document READ document  WRITE setDocument NOTIFY documentChanged)
    Q_PROPERTY(int cursorStart MEMBER _cursorStart)
    Q_PROPERTY(int cursorEnd MEMBER _cursorEnd)
    Q_PROPERTY(int width MEMBER _width)
    Q_PROPERTY(int height MEMBER _height)
    QML_ELEMENT
public:
    explicit RichTextHandler(QObject* parent = nullptr);
    ~RichTextHandler();
    Q_INVOKABLE void insertGif(QQuickTextDocument* qquickDoc, QString fileName);
    Q_INVOKABLE void debug();
    Q_INVOKABLE QString coding();
    Q_INVOKABLE void encoding(QString text);

    QQuickTextDocument* document();
    void setDocument(QQuickTextDocument* document);

public slots:
    void onMoveUpdate();
    void insertGifImpl(QQuickTextDocument* qquickDoc, QString fileName);

signals:
    void documentChanged();
    void needUpdate();

private:
    bool addMovie(QString fileName);
    QImage loadLocalImage(const QString &path);
    QImage loadResourceImage(const QString &resourcePath);
    QImage scaleImage(const QImage &image);
    QSize adjustImageSize(const QSize &originalSize);
    QString imageToBase64(const QImage& image);

    QQuickTextDocument* _documnt;
    int _cursorStart;
    int _cursorEnd;
    int _width;
    int _height;
    int _encodeCount = 0;
    qreal _maxImageWidth = 300;
    qreal _maxImageHeight = 450;
    QHash<QString, QMovie*> _movies;
    QTimer _moveTimer;
};

#endif // RICH_TEXT_HANDLER__H
