/****************************************************************************
**  剪贴板处理
** Author   : chrisLee
** Create   : 2025-06-13
****************************************************************************/

#ifndef RELAX_CLIPBOARD_HELPER__H
#define RELAX_CLIPBOARD_HELPER__H

#include <QObject>
#include <QImage>
#include <QQuickItem>

class ClipboardHelper : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString text READ text NOTIFY textChanged)
    Q_PROPERTY(QImage image READ image NOTIFY imageChanged)

    QML_ELEMENT

public:
    explicit ClipboardHelper(QObject *parent = nullptr);

    Q_INVOKABLE QString saveImageToTemp();
    Q_INVOKABLE bool hasImage();
    Q_INVOKABLE bool hasText();

    QString text() const;

    QImage image() const;


signals:
    void textChanged();
    void imageChanged();
    void hasImageChanged();
    void hasTextChanged();
};

#endif // RELAX_CLIPBOARD_HELPER__H
