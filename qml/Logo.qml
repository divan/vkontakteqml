import QtQuick 1.0

Rectangle {
    width: parent.width
    height: 64
    z: 3
    color: "#4e729a"
    gradient: Gradient {
         GradientStop { position: 0.0; color: "#42658c" }
         GradientStop { position: 1.0; color: "#5a7da5" }
    }
    Row {
        Image {
            id: logoImage
            source: "qrc:/images/vk_logo.png"
            fillMode: Image.PreserveAspectCrop
        }
    }
}
