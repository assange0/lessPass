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
    engine.load(QUrl(QLatin1String("qrc:/pages/LessPass.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
