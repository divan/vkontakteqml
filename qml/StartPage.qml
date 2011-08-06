import QtQuick 1.0
import com.meego 1.0

Page {
    id: startPage
    tools: startPageTools
    property string token: ""
    anchors.fill: parent
    Logo { id: logo; }
    ToolBarLayout {
        id: startPageTools 
        visible: true
        ToolIcon { platformIconId: "toolbar-view-menu";
             anchors.right: parent===undefined ? undefined : parent.right
             onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }
    Rectangle {
        id: backgroundRect
        border.color: "#5a7da5" 
        border.width: 40
        radius: 40
        smooth: true
        color: "#ddddff"
        anchors.top: logo.bottom;
        width: parent.width
        height: parent.height - logo.height
        Item {
            id: wrapper
            anchors {
                leftMargin: 20
                topMargin: 30
                bottomMargin: 30
                rightMargin: 30
            }
            anchors.fill: parent
            ListView {
                id: startList
                anchors.fill: parent
                model: menuModel
                delegate: Item {
                    width: parent.width
                    height: 72
                    anchors.left: parent.left
                    anchors.margins: 20
                    Column {
                    spacing: 20
                    Row {
                        width: parent.width
                        spacing: 20
                        Image {
                            id: listImage
                            height: 64
                            source: icon
                        }
                        Text {
                            id: listText
                            height: 64
                            text: name
                            font.pointSize: 24
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                    Rectangle {
                        id: separatorLine
                        color: "white"
                        width: startList.width - 20
                        height: 1
                        visible: true
                    }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: { appWindow.pageStack.push(Qt.resolvedUrl(page), { token: token }) }
            
                    }
                }
            }
        }
    }
    ListModel {
        id: menuModel
        ListElement {
            name: "NewsFeed"
            updatesNumber: 12
            icon: "/opt/vkontakte/images/news.png"
            page: "NewsPage.qml"
        }
        ListElement {
            name: "Wall"
            updatesNumber: 12
            icon: "/opt/vkontakte/images/wall.png"
            page: "NewsPage.qml"
        }
        ListElement {
            name: "Photos"
            updatesNumber: 12
            icon: "/opt/vkontakte/images/photos.png"
            page: "NewsPage.qml"
        }
        ListElement {
            name: "Videos"
            updatesNumber: 12
            icon: "/opt/vkontakte/images/videos.png"
            page: "NewsPage.qml"
        }
    }
}
