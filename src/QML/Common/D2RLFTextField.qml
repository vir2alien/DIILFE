import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

TextField {id: control
    topPadding: 2
    bottomPadding: 0
    leftPadding: 0
    rightPadding: 0
    font.pointSize: fontBody1
    horizontalAlignment: Text.AlignLeft
    inputMethodHints: Qt.ImhNoPredictiveText

    selectByMouse: true
    wrapMode: TextField.WordWrap
    background: null
    Rectangle {id: bottomLine
        y: control.height - height - control.bottomPadding + control.topPadding
        width: parent.width
        height: control.activeFocus || control.hovered ? 2 : 1
        color: control.activeFocus ? control.Material.accentColor
                                   : (control.hovered ? control.Material.primaryTextColor : control.Material.hintTextColor)
    }
}
