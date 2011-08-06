import QtQuick 1.1
import com.meego 1.0
import "../js/vkontakte.js" as Vkontakte

Page {
    id: newsPage
    tools: newsTools 
    Component.onCompleted: { Vkontakte.getNewsfeed(); }
    property string token: ""

    Logo { id: logo; }
    QuickPost {
        id: quickPost;
        anchors.top: logo.bottom;
    }
    ListView {
        id: newsList
        anchors.top: quickPost.bottom
        width: parent.width
        height: parent.height - logo.height - quickPost.height
        model: NewsFeedModel { id: newsFeedModel }
        delegate: NewsFeedDelegate { }
    }
    BusyIndicator {
        id: busyIndicator
        anchors { centerIn: parent; verticalCenterOffset: -20 }
        running: newsFeedModel.isReady != true
        visible: newsFeedModel.isReady != true
    }
    ToolBarLayout {
        id: newsTools
        visible: true
        ToolIcon { platformIconId: "toolbar-back"; onClicked: pageStack.pop(); }
        ToolIcon { platformIconId: "toolbar-view-menu";
             anchors.right: parent===undefined ? undefined : parent.right
             onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }
}
