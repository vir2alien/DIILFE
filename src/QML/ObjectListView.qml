import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "Common"
import "ObjectListView"

Column {id: diirlflistview
    property int delegateHeight: Material.delegateHeight
    property int headerHeight: Material.delegateHeight
//    property int footerHeight: 40
    property int fullContentHeigh: delegateHeight*model.rowCount + headerHeight// + footerHeight
    property string textRole: ""
    property string filterText: ""

    property alias currentItem: list.currentItem
    property int currentIndex: list.currentIndex
    property alias keyNavigationEnabled: list.keyNavigationEnabled
    property alias model: list.model

    width: 250
    spacing: 0

    function focusOnList() {
        list.interactive = true;
        list.focus = true;
    }

    function removeCurrent() {
        if (list.currentIndex < 0) {
            return;
        }
        itemIndexToBeRemoved = list.currentIndex;
        dboModel.remove(list.currentIndex);
    }

    Item {id: header
        width: parent.width
        height: headerHeight
        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 1
            color: Material.backgroundColor
        }
        D2RLFTextField {id: searchField
            anchors.fill: parent
            bottomPadding: topPadding
            leftPadding: baseMargins
            rightPadding: baseMargins
            inputMethodHints: Qt.ImhSensitiveData//TODO нужно в android
            onTextChanged: {
                filterText = text;
                focus = true;
            }
            onEditingFinished: focus = false
            D2RLFMaterialIconLabel {id: searchIcon
                anchors {
                    left: parent.left
                    leftMargin: baseMargins
                    verticalCenter: parent.verticalCenter
                }
                height: searchField.font.pixelSize
                iconSize: searchField.font.pixelSize
                color: Material.color(Material.Grey)
                visible: searchField.text.length === 0// && searchField.focus === false
                iconName: "search"
            }
            D2RLFLabel {
                anchors {
                    left: searchIcon.right
                    leftMargin: baseMargins/2
                    verticalCenter: parent.verticalCenter
                }
                color: Material.color(Material.Grey)
                visible: searchField.text.length === 0
                text: qsTr("Найти")
            }
            D2RLFMaterialButton {
                anchors {
                    right: langBtn.left
                    verticalCenter: parent.verticalCenter
                }
                visible: searchField.text.length > 0
                onClicked: searchField.text = ""
                iconName: "backspace"
                toolTipText: qsTr("Удалить текст")
            }
            D2RLFMaterialButton {id: langBtn
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                width: height
                topInset: 0
                bottomInset: 0
                padding: 0
                iconName: "language"
                toolTipText: qsTr("Язык таблицы")
                onClicked: langSelect.open()
                LangSelectPopup {id: langSelect

                }
            }
        }
        D2RLFHorisontalSeparator {
            anchors.top: parent.bottom
            width: parent.width
        }
    }//Item

    ListView {id: list
        //currentIndex: dboModel.currentIndex
        clip: true
        width: parent.width
        height: diirlflistview.height - headerHeight// - footerHeight
        ScrollBar.vertical: ScrollBar {
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }
        }
        delegate: Item {
            width: list.width
            height: delegateHeight*2/3
            property int listCurrentIndex: currentIndex
            property variant modelData: model

            D2RLFLabel {id: label
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                leftPadding: baseMargins
                text: {
                    var edata = model[textRole];
                    edata = edata.replace(/\n/g, '');
                    edata = edata.trim();

                    if (!edata.includes('[')) {
                        return edata;
                    }
                    const parts = edata.split(/\[.*?\]/g).filter(part => part !== '');
                    return parts.join(', ');
                }
            }
            MouseArea {id: itemBtn
                property bool hovered: false
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hovered = true
                onExited: hovered = false
                onClicked: {
                    diirlflistview.currentIndex = model.index;
                    list.currentIndex = model.index;
                }
            }
            Rectangle {
                anchors.fill: parent
                visible: itemBtn.hovered || listCurrentIndex === model.index
                color: Material.rippleColor
            }
            Rectangle {
                anchors.fill: parent
                visible: itemBtn.pressed
                color: Material.rippleColor
            }
        }//delegate

        onFocusChanged: {
            //console.log("List focus has changed " + focus);
        }
    }

    // Item {id: footer//WIP
    //     width: parent.width
    //     height: footerHeight
    //     Rectangle {
    //         anchors.fill: parent
    //         //anchors.margins: 1
    //         color: Material.backgroundColor
    //     }
    //     D2RLFHorisontalSeparator {
    //         anchors.top: parent.top
    //         width: parent.width
    //     }
    //     D2RLFMaterialButton {
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         implicitHeight: footerHeight
    //         width: height
    //         padding: 0
    //         topPadding: 0
    //         bottomPadding: 0
    //         topInset: 0
    //         bottomInset: 0
    //         iconName: "add"
    //         onClicked: objectAddRequest()//dboModel.addObject()
    //     }
    // }//Item
}
