import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material

ComboBox {id: control
    background: null
    height: Material.delegateHeight
    flat: true

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: implicitContentHeight + topPadding + bottomPadding

    font.pointSize: fontBody1

    delegate: MenuItem {
        font: control.font
        width: parent.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        Material.foreground: control.currentIndex === index ? parent.Material.accent : parent.Material.foreground
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
    }

    contentItem: D2RLFTextField {id: textField
        height: control.height

        topInset: 0
        bottomInset: 0
        topPadding: 0

        leftPadding: 0
        background: null
        bottomPadding: topPadding
        text: control.editable ? control.editText : control.displayText
        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        font: control.font
        color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
        selectionColor: control.Material.accentColor
        selectedTextColor: control.Material.primaryHighlightedTextColor
        verticalAlignment: Text.AlignVCenter
    }
}
