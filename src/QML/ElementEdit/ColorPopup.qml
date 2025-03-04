import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import "qrc:/Common"

Popup {id: colorPopup
    width: 350
    height: 350
    modal: false
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    GridLayout {
        anchors.fill: parent
        anchors.margins: 10
        columns: 4
        rowSpacing: 10
        columnSpacing: 10
        Repeater {
            model: colorListModel
            delegate: Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: model.cvalue
                radius: 3

                D2RLFLabel {
                    anchors.centerIn: parent
                    text: model.dcode
                    font.bold: true
                    color: {
                        if (model.cvalue === "#010101") {
                            return "white";
                        } else {
                            return "black;"
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        insertColor(model.dcode)
                        colorPopup.close()
                    }
                }
            }
        }
    }
}
