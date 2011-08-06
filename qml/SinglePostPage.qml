import QtQuick 1.1
import com.meego 1.0

Page {
    id: singlePost
    tools: singlePostTools 
    property string post_id: ""
    property string poster_name: ""
    property string post_text: ""
    property string avatar: ""
    property string date: ""
    property string comments_count: ""
    property string likes_count: ""

    Logo { id: logo }
    PinchArea {
        id: pinchArea
        pinch.target: content
        anchors.fill: parent
        pinch.dragAxis: Pinch.NoDrag
        onPinchUpdated: { console.log("Pinch Updated: " + pinch.scale);
                    postText.font.pointSize = postText.font.pointSize + 2*(pinch.scale-1) }
    }
    Flickable {
        id: flickable
        flickableDirection: Flickable.VerticalFlick
        contentWidth: parent.width
        contentHeight: content.height
        width: parent.width
        height: parent.height
        anchors.top: logo.bottom
        smooth: false
        Item {
            id: content
            x: 5
            width: parent.width
            height: posterText.height + postText.height + dateText.height + 128
            Item {
                id: avatarFrame
                width: avatarImage.width + 5
                height: avatarImage.height
                y: 10
                opacity: 0.5

                Image {
                    id: avatarImage
                    source: avatar
                    width: 100
                    height: 100
                    x: 5
                }
            }
            Text {
                id: posterText
                text: poster_name
                anchors.left: avatarFrame.right
                anchors.leftMargin: 10
                anchors.topMargin: 10
                width: parent.width - avatarFrame.width - 10
                wrapMode: Text.WordWrap
                font.pointSize: 24
                color: "steelblue"
                font.bold: true
                verticalAlignment: Text.AlignTop
            }
            Text {
                id: postText
                smooth: false
                anchors.left: avatarFrame.right
                anchors.leftMargin: 10
                anchors.top: posterText.bottom
                anchors.topMargin: 10
                width: parent.width - avatarFrame.width - 10
                text: post_text
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                verticalAlignment: Text.AlignTop
                font.family: "Helvetica"
                font.pointSize: 24
            }
            Row {
                width: parent.width
                anchors.top: postText.bottom
                anchors.topMargin: 5
                anchors.rightMargin: 5
                Text {
                    id: dateText
                    text: date
                    font.pointSize: 14
                    font.italic: true
                    horizontalAlignment: Text.AlignLeft
                    color: "grey"
                }
                Text {
                    id: commentsText
                    text: comments_count + qsTr(" comments") +
                          ", " + likes_count + qsTr(" likes")
                    width: parent.width - dateText.width
                    font.pointSize: 14
                    horizontalAlignment: Text.AlignRight
                    color: "grey"
                }
            }
        }
    }
    ToolBarLayout {
        id: singlePostTools 
        visible: true
        ToolIcon { platformIconId: "toolbar-back"; onClicked: pageStack.pop(); }
        ToolIcon { platformIconId: "toolbar-view-menu";
             anchors.right: parent===undefined ? undefined : parent.right
             onClicked: (myMenu.status == DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }
}
