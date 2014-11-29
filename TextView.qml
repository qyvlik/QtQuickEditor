/*work for desktop and harmattan
 *some bug,can't auto fix TextEdit width
 *
 *by qyvlik
 *qyvlik@qq.com
 *2014/10/25/11:33
 *China
 *
*/

import QtQuick 1.1

Item {
    id:root

    property alias text: showText.text
    property alias readOnly: showText.readOnly
    property int textPointSize : 20
    property bool hold: false
    property int lineLength
    property alias textScale: showText.scale


    Flickable {
        id: flickable
        anchors{
            right: parent.right
            rightMargin: 1
            left: parent.left
            leftMargin: 1
            bottom: parent.bottom
            bottomMargin: 10
            top:parent.top
            topMargin: 2
        }
        contentHeight :showText.height
        contentWidth: showText.width//lineLength
        enabled: !hold
        smooth: true

        Column{
            id:showLineCount
            anchors.left: parent.left

            Repeater {
                model: showText.lineCount;

                Rectangle {
                    width: lineNumberWidth(showText.lineCount) +10
                    height:temp.height;
                    /*
                      in desktop
                      TextEdit and Text, they 's font.pointSize is 8
                      TextEdit's height is 13(one line)
                      Text's height is 11(one line)
                    */
                    color: "yellow"

                    Rectangle {
                        property bool flag:false
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        width: 10
                        height: 10
                        color:"yellow"
                        radius:5
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                if(parent.flag) {
                                    parent.color = "yellow";
                                    parent.flag = false;
                                } else {
                                    parent.color = "green";
                                    parent.flag = true;
                                }
                            }
                        }
                    }

                    Text {
                        id:showLineNumber
                        font.pointSize: textPointSize;
                        anchors{
                            bottom:parent.bottom
                            bottomMargin: 1
                            horizontalCenter: parent.horizontalCenter
                        }
                        text:index+1
                        color:"red"

                    }
                }
            }
        }

        TextEdit {
            id:showText
            width: root.width
            anchors{
                left:showLineCount.right
            }
            font.pointSize:textPointSize;
            wrapMode:TextEdit.NoWrap
            textFormat:TextEdit.PlainText
            focus: true
            activeFocusOnPress:true
        }
    }

    TextEdit{
        id:temp
        font.pointSize: textPointSize;
        visible: false
        text:"hello word"
        /*
          in desktop
          TextEdit and Text, they 's font.pointSize is 8
          TextEdit's height is 13(one line)
          Text's height is 11(one line)
        */
    }

    Rectangle {
        id: verticalScrollbar
        anchors.right: parent.right
        anchors.rightMargin: 2
        y: flickable.visibleArea.yPosition * flickable.height
        width: 5
        height : flickable.visibleArea.heightRatio * flickable.height
        radius: 2
        color: "#b19393"
    }

    Rectangle {
        id: horizontalScrollbar
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        x: flickable.visibleArea.xPosition * flickable.width
        height: 5
        width : flickable.visibleArea.widthRatio * flickable.width
        radius: 2
        color: "#b19393"
    }

   function lineNumberWidth(lineCount) {
        var width = 1;
        var space = 0;
        while(lineCount >= 10) {
            lineCount /= 10;
            ++width;
        }
        return space = width * 20
    }

    function clearText () {
        text = ""
    }
    function fixViewWidth(text) {
        var i=0;
        var maxWidth = 0;
        var tempArray = new Array();
        var tempstr1 = new String();

        tempArray = text.split("\n");
        tempstr1 = tempArray[i];

        while(tempstr1) {
            if(maxWidth<=tempstr1.length) {
                maxWidth=tempstr1.length;
                console.log("\t<<"+i+">>\n");
            }
            i+=1;
            tempstr1 = tempArray[i];
        }
        delete tempstr1;
        delete tempArray;
        return maxWidth;
    }

    function fixWidth(){
        flickable.contentWidth = fixViewWidth(showText.text)*16;//Chinese need two width
        console.log("view width is:"+flickable.contentWidth);
    }
}
