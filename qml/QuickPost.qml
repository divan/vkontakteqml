import QtQuick 1.1
import com.meego 1.0
import "../js/vkontakte.js" as Vkontakte

Rectangle {
    id: quickPost
    width: parent.width
    height: 72
    z: 2
    color: "lightgrey" // TODO: set this to default theme's bg color
    TextField {
        id: inputBox
        anchors.margins: 10
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width - postButton.width - 10
        font.pointSize: 24
        placeholderText: qsTr("What are you thinking about?")
        Keys.onReturnPressed: {
            parent.focus = true;
        }
    } 
                        
    Button {
        id: postButton
        anchors.left: inputBox.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 10
        width: 55
        height: 55
        text: "post"
        onClicked: Vkontakte.postOnWall(inputBox.text)
    }
}
