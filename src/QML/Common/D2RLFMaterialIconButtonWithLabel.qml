import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Layouts 1.15
import QtQuick.Templates 2.15 as T
import "qrc:/Common"
ColumnLayout {id: control
    height: btn.height + label.height
    width: 46
    property alias iconSize: btn.iconSize
    property alias iconName: btn.iconName
    property alias checked: btn.checked
    property alias visualFocus: btn.visualFocus
    property alias down: btn.down
    property alias flat: btn.flat
    property alias highlighted: btn.highlighted
    property alias hovered: btn.hovered
    property alias font: label.font
    property alias text: label.text
    signal clicked()

    spacing: 0

    D2RLFMaterialButton {id: btn
        Layout.alignment: Qt.AlignHCenter
        onClicked: control.clicked()
//        bottomInset: 0
//        bottomPadding: 0
    }
    D2RLFLabel {id: label
        topInset: 0
        topPadding: 0
        Layout.alignment: Qt.AlignHCenter
        Layout.fillWidth: true
        Layout.topMargin: -baseMargins
        font.capitalization: Font.AllLowercase
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        font.pointSize: fontBody2
    }
}

