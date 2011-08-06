import QtQuick 1.0
import com.meego 1.0

Item {
    id: postDelegate;
    height: column.height + 20
    width: postDelegate.ListView.view.width

    Item {
        id: avatarFrame
        width: avatarImage.width + 5
        height: avatarImage.height + 5

        Image {
            id: avatarImage
            source: avatar_medium
            width: 92
            height: 92
            x: 5; y: 20
        }
    }

    Column {
        id: column
        spacing: 5
        anchors.left: avatarFrame.right;
        anchors.leftMargin: 10
        y: 20
        width: parent.width - avatarFrame.width - 25
        Text {
            text: poster_name 
            color: "steelblue"
            font.pointSize: 22
            font.bold: true
            verticalAlignment: Text.AlignTop
            width: parent.width
            wrapMode: Text.WordWrap
        }
        Text {
            id: postText
            text: post_text_preview
            width: parent.width
            font.pointSize: 18
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            font.family: "Helvetica"
            verticalAlignment: Text.AlignTop
        }
        Row {
            width: parent.width
            Text {
                id: dateText
                text: date
                font.pointSize: 12
                font.italic: true
                horizontalAlignment: Text.AlignLeft
                color: "grey"
            }
            Text {
                id: commentsText
                text: comments_count + qsTr(" comments") +
                      ", " + likes_count + qsTr(" likes")
                width: parent.width - dateText.width
                font.pointSize: 12
                horizontalAlignment: Text.AlignRight
                color: "grey"
            }
        }
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: {
            appWindow.pageStack.push(Qt.resolvedUrl("SinglePostPage.qml"),
                                     { post_id: post_id,
                                       post_text: post_text,
                                       poster_name: poster_name,
                                       avatar: avatar_medium,
                                       date: date,
                                       comments_count: comments_count,
                                       likes_count: likes_count,
                                      })
        }
    }
}

