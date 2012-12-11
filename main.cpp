#include <QtGui/QGuiApplication>
#include <QtCore/QDebug>
#include <QtQml/QQmlContext>
#include <QtQuick/QQuickItem>
#include <QtCore/QStandardPaths>
#include "qtquick2applicationviewer.h"
#include "filereader.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QUrl fileName;
    qreal volume = 0.5;
    QStringList args = app.arguments();

    for (int i=1; i<args.count(); ++i) {
        const QString &arg = args.at(i);
        if (arg.startsWith('-')) {
            if ("-volume" == arg) {
                if (i+1 < args.count())
                    volume = 0.01 * args.at(++i).toInt();
                else
                    qWarning() << "Option \"-volume\" takes a value";
            }
            else {
                qWarning() << "Option" << arg << "ignored";
            }
        } else {
            if (fileName.isEmpty())
                fileName = QUrl::fromLocalFile(arg);
            else
                qWarning() << "Argument" << arg << "ignored";
        }
    }

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/CuteTime/main.qml"));
    QQuickItem *rootObject = viewer.rootObject();
    rootObject->setProperty("fileName", fileName);
    rootObject->setProperty("volume", volume);

    FileReader fileReader;
    viewer.rootContext()->setContextProperty("fileReader", &fileReader);

    QString imagePath = "../../images";
    const QStringList picturesLocation = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    if (!picturesLocation.isEmpty())
        imagePath = picturesLocation.first();
    viewer.rootContext()->setContextProperty("imagePath", imagePath);
    qDebug() << "Image path: " << imagePath;

    QString videoPath;
    const QStringList moviesLocation = QStandardPaths::standardLocations(QStandardPaths::MoviesLocation);
    if (!moviesLocation.isEmpty())
        videoPath = moviesLocation.first();
    viewer.rootContext()->setContextProperty("videoPath", videoPath);
    qDebug() << "Video path: " << videoPath;

    viewer.setTitle("CuteTime");

    viewer.showExpanded();

    return app.exec();
}
