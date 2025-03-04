import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import "qrc:/Common"
ColumnLayout {
    property alias currentIndex: elementsListView.currentIndex
    width: 300
    function updateModel(index) {
        elementListModel.clear();
        const item = filteredListModel.get(index);
        for (let i = 0; i < langCodes.length; i++) {
            elementListModel.append({lang: langCodes[i], content: item[langCodes[i]]});
        }
    }

    GridLayout {
        Layout.topMargin: baseMargins
        columns: 2
        D2RLFLabel {
            text: "ID:"
            Layout.preferredWidth: 50
            leftPadding: baseMargins
        }
        D2RLFLabel {
            text: listView.currentItem !== null ? listView.currentItem.modelData.id: ""
        }

        D2RLFLabel {
            text: "Key:"
            Layout.preferredWidth: 50
            leftPadding: baseMargins
        }
        D2RLFLabel {
            text: listView.currentItem !== null ? listView.currentItem.modelData.Key: ""
        }
    }
    D2RLFHorisontalSeparator {
        Layout.fillWidth: true
    }

    ListView {id: elementsListView
        property int currentIndex: -1

        Layout.fillHeight: true
        Layout.fillWidth: true
        spacing: 0
        clip: true

        model: elementListModel
        delegate: Item {
            width: elementsListView.width
            height: delegateHeight*2/3

            Row {
                anchors.fill: parent
                D2RLFLabel {
                    width: 50
                    height: parent.height
                    leftPadding: baseMargins
                    text: model.lang
                }
                D2RLFLabel {
                    height: parent.height
                    text: ": "
                }
                D2RLFLabel {
                    height: parent.height
                    text: model.content.replace(/\n/g, '\\n')
                }
            }

            MouseArea {id: itemBtn
                property bool hovered: false
                anchors.fill: parent
                hoverEnabled: true
                onEntered: hovered = true
                onExited: hovered = false
                onClicked: {
                    elementsListView.currentIndex = model.index;
                }
            }
            Rectangle {
                anchors.fill: parent
                visible: itemBtn.hovered || elementsListView.currentIndex === model.index
                color: Material.rippleColor
            }
            Rectangle {
                anchors.fill: parent
                visible: itemBtn.pressed
                color: Material.rippleColor
            }
        }
    }//ListView
}


