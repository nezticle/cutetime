# Add more folders to ship with the application, here
folder_qml.source = qml/CuteTime
folder_qml.target = qml
folder_shaders.source = shaders
DEPLOYMENTFOLDERS = folder_qml folder_shaders

QT += widgets

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += \
    main.cpp \
    filereader.cpp

HEADERS += \
    filereader.h

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    TODO.txt \
    README.txt \
    android/AndroidManifest.xml \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/src/org/kde/necessitas/origo/QtActivity.java \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/version.xml \
    android/res/values-rs/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/values-es/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/res/values-ru/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/values/strings.xml \
    android/res/values/libs.xml \
    android/res/layout/splash.xml \
    android/res/values-et/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-de/strings.xml \
    android/res/values-nl/strings.xml \
    android/res/drawable-hdpi/icon.png \
    android/res/values-nb/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-el/strings.xml \
    android/res/drawable/logo.png \
    android/res/drawable/icon.png \
    android/AndroidManifest.xml \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/qtproject/qt5/android/bindings/QtApplication.java \
    android/src/org/qtproject/qt5/android/bindings/QtActivity.java \
    android/version.xml \
    android/res/values-rs/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/values-es/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/res/values-ru/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/values/strings.xml \
    android/res/values/libs.xml \
    android/res/layout/splash.xml \
    android/res/values-et/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-de/strings.xml \
    android/res/values-nl/strings.xml \
    android/res/drawable-hdpi/icon.png \
    android/res/values-nb/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-el/strings.xml \
    android/res/drawable/logo.png \
    android/res/drawable/icon.png \
    android/AndroidManifest.xml \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/qtproject/qt5/android/bindings/QtApplication.java \
    android/src/org/qtproject/qt5/android/bindings/QtActivity.java \
    android/version.xml \
    android/res/values-rs/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/values-es/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values-ru/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/values/strings.xml \
    android/res/values/libs.xml \
    android/res/layout/splash.xml \
    android/res/values-et/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-de/strings.xml \
    android/res/values-nl/strings.xml \
    android/res/values-nb/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-el/strings.xml

RESOURCES += \
    resources.qrc
