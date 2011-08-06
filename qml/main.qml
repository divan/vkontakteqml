import QtQuick 1.1
import com.meego 1.0
import "../js/oauth.js" as OAuth

PageStackWindow {
    id: appWindow
    anchors.bottom: sharedToolBar.top

    Component.onCompleted: OAuth.checkToken()

    initialPage: StartPage { }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem { text: "Sample menu item" }
        }
    }
}
