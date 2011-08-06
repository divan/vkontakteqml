function urlChanged(url)
{
    console.log(url)
    var authorized = false;
    var mUrl = url.toString();
    var code = "";
    if (mUrl.indexOf("http://api.vkontakte.ru/blank.html") > -1)
    {
        var query = mUrl.substring(mUrl.indexOf('#') + 1);
        var vars = query.split("&");
        for (var i=0; i<vars.length; i++)
        {
            var pair = vars[i].split("=");
            if (pair[0] == "access_token")
            {
                authorized = true;
                token = pair[1];
                console.log("Hooray!")
            }
        }
    }
    if (authorized)
    {
        var db = openDatabaseSync("Vkontakte", "1.0", "acces_token", 1);
        var delStr = "DELETE FROM Vkontakte";
        var dataStr = "REPLACE INTO Vkontakte VALUES(?)";
        var data = [token];
        db.transaction(function(tx)
        {
            tx.executeSql('CREATE TABLE IF NOT EXISTS Vkontakte(token TEXT)');
            tx.executeSql(delStr);
            tx.executeSql(dataStr, data);
        });
        console.log("This is token: " + token)
        checkToken()
    }
}

function checkToken() {
    var db = openDatabaseSync("Vkontakte", "1.0", "access_token", 1);
    var dataStr = "SELECT * FROM Vkontakte";
    db.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Vkontakte(token TEXT)');
        var rs = tx.executeSql(dataStr);
        console.log("Rows count: " + rs.rows.length)
        if (rs.rows.length>0 && rs.rows.item(0).token) {
            console.log("AuthDone")
            //appWindow.pageStack.push(Qt.resolvedUrl("NewsPage.qml"), { token: rs.rows.item(0).token })
            appWindow.pageStack.push(Qt.resolvedUrl("StartPage.qml"), { token: rs.rows.item(0).token })
        } else {
            console.log("Auth NOT Done")
            appWindow.pageStack.push(Qt.resolvedUrl("AuthPage.qml"))
        }
    });
}
