#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QStandardPaths>


int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // 获取可执行文件所在目录
    QString applicationDirPath = QCoreApplication::applicationDirPath();

    // 确保路径使用正斜杠
    applicationDirPath.replace('\\', '/');

    // 设置上下文属性，使QML可以访问
    engine.rootContext()->setContextProperty("applicationDirPath", applicationDirPath);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("MyApp", "Main");

    return app.exec();
}
