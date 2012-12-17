#include <QtWidgets/QApplication>
#include <QtCore/QDebug>
#include <QtQml/QQmlContext>
#include <QtQuick/QQuickItem>
#include <QtCore/QStandardPaths>
#include "qtquick2applicationviewer.h"
#include "filereader.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

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
                fileName = QUrl(arg);
            else
                qWarning() << "Argument" << arg << "ignored";
        }
    }

    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("fileName", fileName);
    viewer.rootContext()->setContextProperty("startingVolume", volume);
    viewer.setMainQmlFile(QStringLiteral("qml/CuteTime/main.qml"));
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    QQuickItem *rootObject = viewer.rootObject();

    FileReader fileReader;
    viewer.rootContext()->setContextProperty("fileReader", &fileReader);

    QString imagePath = "../../images";
    const QStringList picturesLocation = QStandardPaths::standardLocations(QStandardPaths::PicturesLocation);
    if (!picturesLocation.isEmpty())
        imagePath = picturesLocation.first();
    viewer.rootContext()->setContextProperty("imagePath", imagePath);

    QString videoPath;
    const QStringList moviesLocation = QStandardPaths::standardLocations(QStandardPaths::MoviesLocation);
    if (!moviesLocation.isEmpty())
        videoPath = moviesLocation.first();
    viewer.rootContext()->setContextProperty("videoPath", videoPath);
    viewer.rootContext()->setContextProperty("viewer", &viewer);

    viewer.setTitle("CuteTime");

    viewer.showExpanded();

    return app.exec();
}
