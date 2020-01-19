/**
* @brief 摘要
* @author Roger Aries
* @date 2017/08/01
*/

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "genpass.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<GenPass>("io.qt.genpass", 1, 0, "GenPass");

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/pages/LessPass.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
