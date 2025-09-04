import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import DIIRLFE 1.0

Popup {id: popup
    property int itmHeight: delegateHeight*2/3
    width: 150
    height: itmHeight*langListModel.count//500//fullContentHeigh
    leftPadding: 0
    rightPadding: 0
    topPadding: 0
    bottomPadding: 0

    modal: false
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

    ListView {id: listView
        anchors.fill: parent
        model: langListModel
        clip: true
        delegate: D2RLFLabel {
            width: listView.width
            height: itmHeight
            text: model.text
            leftPadding: baseMargins
            MouseArea {id: itemBtn
                property bool hovered: false
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hovered = true
                onExited: hovered = false
                onClicked: {
                    currentLang = model.value;
                    popup.close();
                }
            }
            Rectangle {
                anchors.fill: parent
                visible: itemBtn.hovered
                color: Material.rippleColor
            }
        }
    }
}
