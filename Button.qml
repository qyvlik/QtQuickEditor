/*work for desktop and harmattan
 *
 *by qyvlik
 *qyvlik@qq.com
 *2014/10/25/11:33
 *China
 *
*/

import QtQuick 1.1

Rectangle {
    id: root
    property alias text: name.text

    signal click;

    width: 100
    height: 50
    color: "yellow"
    radius: height/10

    Text {
        id:name
        anchors.centerIn: parent
        text:"click"
    }

    MouseArea {
        anchors.fill: parent
        id:mouse
    }
    Component.onCompleted: {
        mouse.clicked.connect(root.click)
    }
}
