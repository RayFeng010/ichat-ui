#include "rich_text_handler.h"

#include <QDebug>
#include <QTextCursor>
#include <QTextBlock>
#include <QRegularExpression>
#include <QRegularExpressionMatch>
#include <QBuffer>
#include <QThread>

static QString GIF_PREFIXDIR = "emoji/res/";

RichTextHandler::RichTextHandler(QObject *parent) : QObject(parent),_documnt(NULL),_width(28),_height(28),
    _moveTimer(this)
{
    connect(&_moveTimer, SIGNAL(timeout()), this, SLOT(onMoveUpdate()));
    _moveTimer.start(50);
}


RichTextHandler::~RichTextHandler()
{
    QList<QString> list = _movies.keys();
    for(int i=0;i<list.length();i++) {
        delete _movies[list[i]];
    }
    _movies.clear();
}

QQuickTextDocument* RichTextHandler::document()
{
    return _documnt;
}

//qml中设置TextArea的文档
void RichTextHandler::setDocument(QQuickTextDocument *document)
{
    _documnt = document;
}

QString RichTextHandler::coding()
{
    return "";
    QString ret("");
    QTextBlock block = _documnt->textDocument()->firstBlock();
    QVector<QTextFormat> allFormats = _documnt->textDocument()->allFormats();

    while(block.isValid()) {
        for(QTextBlock::iterator it = block.begin(); !it.atEnd(); it++) {
            QTextCharFormat charFmt = it.fragment().charFormat();
            if (charFmt.objectType() == QTextFormat::ImageObject) {
                ret.append("["+charFmt.property(QTextFormat::ImageName).toString().remove(GIF_PREFIXDIR)+"]");

            } else {
                ret.append(it.fragment().text());
            }
        }
        if (block.next().isValid())
            ret.append("\r\n");

        block = block.next();
    }
    qDebug()<< "RichTextHandler coding called";
    return ret;
}

//编码富文本
void RichTextHandler::encoding(QString text)
{
    _encodeCount++;
    if (!_documnt) {
        qDebug()<<"encoding: _documnt == nullptr";
        return;
    }

    //初始化文档位置
    QTextCursor  cursor = QTextCursor(_documnt->textDocument());
    cursor.setPosition(0);

    auto doc = new QTextDocument();
    doc->setHtml(text);  // 加载富文本

    // 最大允许尺寸
    const int maxWidth = 400;
    const int maxHeight = 500;

    // 遍历所有文本块
    for (QTextBlock block = doc->begin(); block.isValid(); block = block.next()) {
        // 复制块格式（段落格式）
        QTextBlockFormat blockFormat = block.blockFormat();

        // 遍历块内的文本片段
        for (QTextBlock::iterator it = block.begin(); !it.atEnd(); ++it) {
            QTextFragment fragment = it.fragment();
            if (!fragment.isValid()) continue;

            QTextCharFormat charFormat = fragment.charFormat();
            // 1. 检查是否为图片
            if (charFormat.isImageFormat()) {
                // imageFormat-> = charFormat.toImageFormat();

                QString imageName = charFormat.toImageFormat().name();

                // 判断是否为 Base64 编码图像
                if (QUrl(imageName).isValid() &&
                    !imageName.startsWith(":/") &&  // 排除 Qt 资源路径
                    !imageName.startsWith("qrc:")) {
                    // 文件 URL 或网络资源
                    qDebug() << "[EXTERNAL IMAGE] URL:" << imageName;

                    // 可以进一步分类
                    if (imageName.startsWith("http", Qt::CaseInsensitive)) {
                        qDebug() << "  Type: Network resource";
                        break;
                    }

                    //读取图片
                    QString filePath = QUrl(imageName).isLocalFile() ? QUrl(imageName).toLocalFile() : imageName;
                    QImage image(filePath);
                    if (image.isNull()) {
                        qDebug() << "Failed to load local image:" << filePath;
                        break;
                    }

                    qDebug() << "Loaded local image:" << filePath << image.size() << "cursor pos: " << cursor.position();

                    QSize newSize = adjustImageSize(image.size());
                    if(!newSize.isEmpty()){
                        QTextImageFormat imageFormat;
                        imageFormat.setName(imageName);
                        imageFormat.setWidth(newSize.width());
                        imageFormat.setHeight(newSize.height());

                        // 创建HTML图像标签
                        QString base64Data = imageToBase64(image);
                        QString imageId = "image" + QString::number(base64Data.size());
                        QString html = QString("<img src=\"data:image/png;base64,%1\" id=\"%2\" width=\"%3\" height=\"%4\" />")
                                           .arg(base64Data)
                                           .arg(imageId)
                                           .arg(newSize.width())
                                           .arg(newSize.height());

                        //std::string tmp = std::format("<img src = 'data:image/png;base64,{}' id={} width = {} height={} />",
                        //                              base64Data.toStdString(), imageId, newSize.width(), newSize.height());      //html的图片标签, 图片的背景为白色

                        // 前面插入行
                        if(cursor.position() > 0)
                            cursor.insertBlock(blockFormat);

                        // 插入图片 --- 改为html
                        // ursor.insertImage(imageFormat);
                        cursor.insertHtml(html);
                        // cursor.insertHtml(QString::fromStdString(tmp));
                        qDebug() << "Insert image size:" << newSize << ", data size: " << base64Data.size();

                        //后面插入新行（确保后续内容在新行开始）
                        cursor.insertBlock(blockFormat);
                    }
                }
                // 处理 Qt 资源系统中的图像
                else if (imageName.startsWith(":/") || imageName.startsWith("qrc:")) {
                    qDebug() << "[QT RESOURCE] Path:" << imageName;

                    // 从 Qt 资源系统加载
                    // QPixmap pixmap(imageName);
                    // if (!pixmap.isNull()) {
                    //     qDebug() << "  Resource loaded, size:" << pixmap.size();
                    // }
                }
                // 其他情况（通常是文档内嵌资源）
                else {
                    qDebug() << "[DOCUMENT RESOURCE] Name:" << imageName;

                    // 尝试从文档资源获取
                }
            }
            else { // 2. 处理文本（包含换行符）
                cursor.insertText(fragment.text(), charFormat.toCharFormat());
            }
        }
    }

    delete doc;
    qDebug()<<"RichTextHandler encoding done, count: " << _encodeCount;
}

// 图片转换为base64
QString RichTextHandler::imageToBase64(const QImage& image)
{
    if (image.isNull()) return "";

    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);

    // 保存为PNG格式（支持透明度）
    if (!image.save(&buffer, "PNG")) {
        qWarning() << "图片转换失败";
        return "";
    }

    buffer.close();
    return QString::fromLatin1(byteArray.toBase64());
}

QSize RichTextHandler::adjustImageSize(const QSize &originalSize) {
    const int maxWidth = 300;
    const int maxHeight = 400;

    if (originalSize.width() <= maxWidth && originalSize.height() <= maxHeight) {
        return originalSize;
    }

    double ratio = qMin(static_cast<double>(maxWidth) / originalSize.width(),
                        static_cast<double>(maxHeight) / originalSize.height());
    return QSize(static_cast<int>(originalSize.width() * ratio),
                 static_cast<int>(originalSize.height() * ratio));
}

QImage RichTextHandler::scaleImage(const QImage &image)
{
    if (image.isNull()) return image;

    // 计算缩放比例
    qreal scaleFactor = 1.0;
    if (image.width() > _maxImageWidth) {
        scaleFactor = qMin(scaleFactor, static_cast<qreal>(_maxImageWidth) / image.width());
    }
    if (image.height() > _maxImageHeight) {
        scaleFactor = qMin(scaleFactor, static_cast<qreal>(_maxImageHeight) / image.height());
    }

    // 如果不需要缩放，直接返回
    if (qFuzzyCompare(scaleFactor, 1.0)) {
        return image;
    }

    // 缩放图像
    return image.scaled(static_cast<int>(image.width() * scaleFactor),
                        static_cast<int>(image.height() * scaleFactor), Qt::KeepAspectRatio, Qt::SmoothTransformation);
}

QImage RichTextHandler::loadLocalImage(const QString &path)
{
    QString filePath = QUrl(path).isLocalFile() ? QUrl(path).toLocalFile() : path;

    QImage image(filePath);
    if (!image.isNull()) {
        qDebug() << "Loaded local image:" << filePath << image.size();
        return image;
    }
    qWarning() << "Failed to load local image:" << filePath;
    return QImage();
}

QImage RichTextHandler::loadResourceImage(const QString &resourcePath)
{
    QString path = resourcePath;
    if (path.startsWith("qrc:")) {
        path = path.mid(3); // 移除 "qrc:"
    }

    QImage image(path);
    if (!image.isNull()) {
        qDebug() << "Loaded resource image:" << path << image.size();
        return image;
    }
    qWarning() << "Failed to load resource image:" << path;
    return QImage();
}


#if 0
void RichTextHandler::encoding(QString text)
{
    if (!_documnt) {
        qDebug()<<"encoding: _documnt == nullptr";
        return;
    }
    QTextCursor  cursor = QTextCursor(_documnt->textDocument());
    cursor.setPosition(0);
    QRegularExpression re("\\[\\d+\\.gif\\]");
    QRegularExpressionMatch match;
    int offset = 0;
    int fileNum;
    QString file;
    QString ret;
    while (offset < text.length()) {
        match = re.match(text, offset);
        if (match.hasMatch()) {
            sscanf(match.captured(0).toLocal8Bit(),"[%d.gif]", &fileNum);
            file = QString(GIF_PREFIXDIR+"%1.gif").arg(fileNum);

            cursor.insertText(text.mid(offset, match.capturedStart(0) - offset));
            ret.append(text.mid(offset, match.capturedStart(0) - offset));
            addMovie(file);
            QTextImageFormat imageFormat;
            imageFormat.setName(file);
            imageFormat.setWidth(_width);
            imageFormat.setHeight(_height);
            cursor.insertImage(imageFormat, QTextFrameFormat::InFlow);
            offset = match.capturedEnd(0);
        } else {
            ret.append(text.mid(offset, text.length() - offset));
            cursor.insertText(text.mid(offset, text.length() - offset));
            break;
        }
    }
    // qDebug()<<"gifText width: "<<_width<< ", height: "<<_height;
}
#endif

void RichTextHandler::debug()
{
    QTextBlock block = _documnt->textDocument()->firstBlock();
    QVector<QTextFormat> allFormats = _documnt->textDocument()->allFormats();
    while(block.isValid()) {
        QTextBlockFormat blockFmt = block.blockFormat();
        qDebug()<<"block:"<<block.blockFormat()<<block.text()<<block.charFormat().property(QTextFormat::ImageName);
        for(QTextBlock::iterator it = block.begin(); !it.atEnd(); it++) {
            QTextCharFormat charFmt = it.fragment().charFormat();
            if (charFmt.objectType() == QTextFormat::ImageObject) {
                qDebug()<<"image:"<<it.fragment().position()<<charFmt.property(QTextFormat::ImageName);
            } else {
                qDebug()<<"text:"<<it.fragment().position()<<it.fragment().text();
            }
        }
        block = block.next();
    }

}

//插入GIF动画
void RichTextHandler::insertGif(QQuickTextDocument* qquickDoc, QString fileName)
{
    if (!_documnt){
        qDebug() << "RichTextHandler _documnt nullptr";
        return;
    }

    // 在关键位置添加线程ID输出
    // qDebug() << "Current thread:" << QThread::currentThread();
    // qDebug() << "Main thread:" << qApp->thread();
    // qDebug() << "Object thread:" << this->thread();

    // 确保在主线程执行
    qDebug() << "RichTextHandler insertGif ......";
    QMetaObject::invokeMethod(this, "insertGifImpl", Qt::QueuedConnection,
                              Q_ARG(QQuickTextDocument*, _documnt),
                              Q_ARG(QString, fileName));
}

// 在UI线程执行的实际插入操作
void RichTextHandler::insertGifImpl(QQuickTextDocument* qquickDoc, QString fileName) {
    if (!qquickDoc) return;

    qDebug() << "Current thread:" << QThread::currentThread();
    qDebug() << "Main thread:" << qApp->thread();
    qDebug() << "Object thread:" << this->thread();

    QTextCursor  cursor = QTextCursor(_documnt->textDocument());
    cursor.setPosition(_cursorStart);
    qDebug()<<"insertGif: "<<fileName<< ", cursor: " << _cursorStart<<_cursorEnd;
    if (_cursorStart > _cursorEnd) {
        cursor.setPosition(0);
    } else if (_cursorStart != _cursorEnd)
        cursor.setPosition(_cursorEnd, QTextCursor::KeepAnchor);

    bool result = addMovie(fileName);
    if(!result) return;

    QTextImageFormat imageFormat;

    imageFormat.setName(fileName);
    imageFormat.setWidth(_width);
    imageFormat.setHeight(_height);

    cursor.insertImage(imageFormat, QTextFrameFormat::InFlow);
}

bool RichTextHandler::addMovie(QString fileName)
{
    if (_movies.contains(fileName)) {
        qDebug() << "RichTextHandler movie exists";
        return false;
    }

    QMovie *movie = new QMovie(QString(fileName));
    if(movie == nullptr) {
        qDebug() << "RichTextHandler QMovie failed";
        return false;
    }

    movie->setCacheMode(QMovie::CacheNone);
    connect(movie, &QMovie::finished, movie, &QMovie::start);   //循环播放

    qDebug() << "RichTextHandler movie start......";
    movie->start();
    _movies.insert(fileName, movie);
    return true;
}


void RichTextHandler::onMoveUpdate()
{
#define CHECK_GIF_CNT   20
    static int cnt = 0;

    if (cnt > CHECK_GIF_CNT) {
        QList<QString> list = _movies.keys();
        for(int i=0;i<list.length();i++) {
            _movies[list[i]]->setProperty("status",false);
        }

        QTextBlock block = _documnt->textDocument()->firstBlock();
        QVector<QTextFormat> allFormats = _documnt->textDocument()->allFormats();
        while(block.isValid()) {
            QTextBlockFormat blockFmt = block.blockFormat();
            for(QTextBlock::iterator it = block.begin(); !it.atEnd(); it++) {
                QTextCharFormat charFmt = it.fragment().charFormat();
                if (charFmt.objectType() == QTextFormat::ImageObject) {
                    QString file = charFmt.property(QTextFormat::ImageName).toString();
                    if (!_movies.contains(file)) {
                        addMovie(file);
                    }
                    _movies[file]->setProperty("status",true);
                }
            }
            block = block.next();
        }

        for(int i=0;i<list.length();i++) {
            if (_movies[list[i]]->property("status") == false) {
                delete _movies[list[i]];
                _movies.remove(list[i]);
                continue;
            }
        }
        cnt = 0;
    } else {
        cnt += 1;
    }


    int begin = 0;
    QList<QString> list = _movies.keys();
    for(; begin<list.length(); begin++) {
        _documnt->textDocument()->addResource(QTextDocument::ImageResource, list[begin],
                                              _movies[list[begin]]->currentPixmap());
        _movies[list[begin]]->setProperty("status",false);
    }

    if (begin)
        emit needUpdate();
}
