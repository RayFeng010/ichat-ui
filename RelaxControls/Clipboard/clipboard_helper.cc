
#include "clipboard_helper.h"
#include <QGuiApplication>
#include <QMimeData>
#include <QClipboard>
#include <QStandardPaths>
#include <QUrl>
#include <qDebug>
#include <QUuid>

ClipboardHelper::ClipboardHelper(QObject *parent) : QObject(parent)
{

}

// ClipboardHelper::~ClipboardHelper(){

// }

QString ClipboardHelper::text() const
{
    const QMimeData *mime = QGuiApplication::clipboard()->mimeData();
    if (mime && mime->hasText())
        return mime->text();

    return QString();
}

QImage ClipboardHelper::image() const
{
    const QMimeData *mime = QGuiApplication::clipboard()->mimeData();
    if (mime && mime->hasImage()) {
        return qvariant_cast<QImage>(mime->imageData());
    }
    return QImage();
}

bool ClipboardHelper::hasImage()
{
    const QMimeData *mime = QGuiApplication::clipboard()->mimeData();
    if (mime && mime->hasImage()){
        qDebug()<< "ClipboardHelper hasImage: true";
        return true;
    }

    qDebug()<< "ClipboardHelper hasImage: false";
    return false;
}
bool ClipboardHelper::hasText(){
    const QMimeData *mime = QGuiApplication::clipboard()->mimeData();
    if (mime && mime->hasText())
        return true;

    return false;
}

//保存image到临时文件
QString ClipboardHelper::saveImageToTemp() {
    const QMimeData *mime = QGuiApplication::clipboard()->mimeData();
    if (mime->hasImage()) {
        QImage img = qvariant_cast<QImage>(mime->imageData());
        // 生成UUID
        QUuid uuid = QUuid::createUuid();

        // 转换为字符串（默认带花括号）
        QString uuidStr = uuid.toString();

        QString path = QStandardPaths::writableLocation(QStandardPaths::TempLocation) + "/"+ uuid.toString(QUuid::WithoutBraces)+ "clip.png";
        img.save(path);
        qDebug()<< "ClipboardHelper save image path: " << path;
        return QUrl::fromLocalFile(path).toString();
    }
    return QString();
}
