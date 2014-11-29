/*work for desktop and harmattan
 *some bug,can't auto fix TextView width
 *
 *by qyvlik
 *qyvlik@qq.com
 *2014/10/25/11:33
 *China
 *
*/

import QtQuick 1.1

Rectangle {
    width: 360
    height: 360
    TextView{
        id:textView
        anchors{
            fill:parent
            bottomMargin: 50
        }
        textPointSize:10
    }

    Row {
        z:10
        id:toolBar
        anchors{
            bottom: parent.bottom
            bottomMargin: 2
        }

        spacing: 10
        Button{
            id:button
            text:"edit "+!textView.readOnly
            onClick: {
                if(textView.readOnly) {
                    textView.readOnly = false;
                } else {
                    textView.readOnly = true;
                }
                textView.fixWidth();
            }
        }
        Button{
            text:"clear"
            onClick: {
                textView.clearText()
            }
        }
        Button{
            text:"hold "+textView.hold
            onClick: {
                if(textView.hold) {
                    textView.hold = false
                } else {
                    textView.hold = true
                }
            }
        }
    }
}
