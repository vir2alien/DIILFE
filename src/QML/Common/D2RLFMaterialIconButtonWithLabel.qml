import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.impl
import QtQuick.Layouts
import QtQuick.Templates as T

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

