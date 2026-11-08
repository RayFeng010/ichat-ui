/*****************************************************************//**
 * @Copyright (C) 2021 The RelaxWalk Company Ltd.
 * @file   frameless_window.h
 * @brief  无边框窗口, 可以实现拖动窗口, 最大/最小化窗口, 指定拖动范围,
 *         鼠标拖动四个角可以放大/缩小窗口
 *         CopyFrom: https://blog.csdn.net/qq_37997682/category_11280267.html
 * @author sz_lidong@qq.com
 * @date   2025-06-06
 *********************************************************************/
#ifndef FRAMELESSWINDOW_H
#define FRAMELESSWINDOW_H

#include <QQuickWindow>
#include <QQuickItem>
#include <QSize>
#include <QList>

// #include "qian_quick_plugin.h"

class FramelessWindow : public QQuickWindow
{
    Q_OBJECT
    Q_PROPERTY(bool monitorEnable MEMBER m_monitorEnable)
    Q_PROPERTY(bool resizable MEMBER m_resizable)
    Q_PROPERTY(QList<QRect> moveArea MEMBER m_moveArea)
    Q_PROPERTY(bool maximized READ maximized WRITE setMaximized NOTIFY maximizedChanged)

    enum MouseEvent
    {
        Mouse_None = 0,
        Mouse_Pressed,
        Mouse_TopLeft,
        Mouse_Top,
        Mouse_TopRight,
        Mouse_Left,
        Mouse_Move,
        Mouse_Right,
        Mouse_BottomLeft,
        Mouse_Bottom,
        Mouse_BottomRight,
    };

    QML_ELEMENT
public:
    class CatchMonitorKey
    {
    public:
        CatchMonitorKey() {}

        CatchMonitorKey(Qt::Key key, Qt::KeyboardModifier  modifier) : _key(key), _modifier(modifier)
        {}

        Qt::Key _key;
        Qt::KeyboardModifier _modifier;

    };


    explicit FramelessWindow(QWindow* parent = nullptr);
    bool maximized();
    void setMaximized(bool max);

    Q_INVOKABLE void setFrameCursor(Qt::CursorShape cursorShape);
    Q_INVOKABLE void setMonitorKeys(const QVariantList& keys);


protected:
    bool eventFilter(QObject* obj, QEvent* evt) override;
    bool checkMonitorKeys(QObject* obj, QEvent* evt);

signals:
    void resizeUpdate(QSize size);
    void maximizedChanged();
    void monitorKeyPressed(int key, int modifier);
    void monitorKeyReleased(int key, int modifier);
    void focusOut();
    void closed();


private:
    MouseEvent getMousePressEvent(const QPoint& pos);
    MouseEvent getResizeArea(const QPoint& pos);
    void setWindowGeometry(const QPoint& pos);
    void setCursorEvent(MouseEvent event, bool isRefrensh = true);
    void setGeometryCalc(const QSize& size, const QPoint& pos);

    bool m_resizable;
    MouseEvent m_event;
    QPoint m_globalPressPos;    // 鼠标按下的全局坐标
    QPoint m_pressPos;          // 鼠标按下的应用程序内的坐标
    bool m_move;
    QSize  m_preSize;
    QList<QRect> m_moveArea;

    bool m_monitorEnable{ true };
    QMultiMap<int, CatchMonitorKey> m_monitorKeysList{};
};

#endif
