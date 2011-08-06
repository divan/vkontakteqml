function doWebRequest(method, url, params, callback) {
    var doc = new XMLHttpRequest();
    console.log(method + " " + url);

    doc.onreadystatechange = function() {
        if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
            var status = doc.status;
            if(status != 200) {
                console.log("Error: " + status + " " + doc.statusText);
            }
        } else if (doc.readyState == XMLHttpRequest.DONE) {
            var data;
            var contentType = doc.getResponseHeader("Content-Type");
            data = doc.responseText;
            callback(data);
        }
    }

    doc.open(method, url);
    if(params.length > 0) {
        doc.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        doc.setRequestHeader("Content-Length", String(params.length));
        doc.send(params);
    } else {
        doc.send();
    }
}

function getNewsfeed() {
    doWebRequest("GET",
                 "https://api.vkontakte.ru/method/newsfeed.get?count=10" +
                              "&filters=post" +
                              "&access_token=" + token,
                 "",
                 populateNewsfeedModel)
}

function populateNewsfeedModel(data)
{
    newsFeedModel.isReady = false;
    var json = JSON.parse(data);
    //console.log(data)

    if (check_error(json))
        return

    // Parse profiles and prepare map
    var profiles = json.response.profiles;
    var profilesMap = {}, avatarsMap = {}, avatarsMediumMap = {}
    if (profiles && profiles.length > 0)
    {
            for (var i = 0; i != profiles.length; i++) {
                profilesMap[profiles[i].uid] = profiles[i].first_name +
                        " " + profiles[i].last_name
                avatarsMap[profiles[i].uid] = profiles[i].photo
                avatarsMediumMap[profiles[i].uid] = profiles[i].photo_medium_rec
            }
    }

    var groups = json.response.groups;
    var groupsMap = {}, groupAvatarsMap = {}
    if (groups && groups.length > 0)
    {
            for (var i = 0; i != groups.length; i++)
            {
                    groupsMap[groups[i].gid] = groups[i].name
                            groupAvatarsMap[groups[i].gid] = groups[i].photo
            }
    }

    // Parse items and populate model
    var news = json.response.items;
    if (news && news.length > 0)
    {
            for (var i = 0; i != news.length; i++)
            {
                var uid = news[i].source_id
                var dateObj = new Date;
                dateObj.setTime(news[i].date*1000)
                var item = {
                    "type": news[i].type,
                    "post_text_preview": news[i].text.substr(0, 250) + (news[i].text.length > 250 ? "<br /><strong>(...)</strong>" : ""),
                    "post_text": news[i].text,
                    "date": dateObj.toTimeString(),
                    "poster_name": (uid>0) ? profilesMap[uid] : groupsMap[-uid],
                    "post_id": news[i].post_id,
                    "avatar": (uid>0) ? avatarsMap[uid] : groupAvatarsMap[-uid],
                    "avatar_medium": (uid>0) ? avatarsMediumMap[uid] : groupAvatarsMap[-uid],
                    "comments_count": news[i].comments.count,
                    "can_comment": news[i].comments.can_post,
                    "likes_count": news[i].likes.count,
                    "can_like": news[i].likes.can_like,
                }
                newsFeedModel.append(item)
            }
    }
    else
    {
        //TODO: show message 'No items to display'
    }
    newsFeedModel.isReady = true;
}

function check_error(json)
{
    if (json && typeof json === 'object')
    {
        if (json.error && json.error.error_code > 0)
        {
            // TODO: print error_msg and check other errors
            console.log("EE: " + json.error.error_msg)
            appWindow.pageStack.push(Qt.resolvedUrl("AuthPage.qml"))
            return true
        }
    }
    return false
}

function commonCallback(data) {
    newsFeedModel.isReady = false;
    var json = JSON.parse(data);
    console.log(data)

    if (check_error(json))
        return
}

function postOnWall(message) {
    doWebRequest("GET",
                 "https://api.vkontakte.ru/method/wall.post?" +
                              "&message=" + encodeURIComponent(message) +
                              "&access_token=" + token,
                 "", commonCallback)
}
