#include <QtGui/QApplication>
#include <QtDeclarative>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;
    view.setSource(QUrl("/opt/vkontakte/qml/main.qml"));
    view.showFullScreen();
    return app.exec();
}
