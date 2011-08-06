import QtQuick 1.1
import QtWebKit 1.0
import Qt 4.7
import com.meego 1.0
import "../js/oauth.js" as OAuth

Page {
    id: snaprOAuth
    property string nextState: "AuthDone"
    anchors.fill: parent

    property string token: ""

    WebView {
        id: loginView
        visible: true
	anchors.fill: parent
        settings.minimumLogicalFontSize: 24
        scale: 1.2
        settings.zoomTextOnly: true
        onUrlChanged: OAuth.urlChanged(url)
	url: "http://api.vkontakte.ru/oauth/authorize" +
		"?client_id=1899304&scope=15615" +
		"&redirect_url=http://api.vkontakte.ru/blank.html" +
		"&dislay=touch&response_type=token"
    }

    states: [
        State {
            name: "Login"
            PropertyChanges {
                target: loginView
                visible: true
                url: "http://api.vkontakte.ru/oauth/authorize" +
                     "?client_id=1899304&scope=15615" +
                     "&redirect_url=http://api.vkontakte.ru/blank.html" +
                     "&dislay=touch&response_type=token"
            }
        },
        State {
            name: "AuthDone"
            PropertyChanges {
                target: loginView
                visible: false
                opacity: 0
            }
            PropertyChanges {
                target: parent
                state: "ShowMain"
            }
        }
    ]
}
