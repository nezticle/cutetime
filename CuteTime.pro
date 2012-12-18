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
    README.txt
