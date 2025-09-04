import QtQuick
import QtQuick.Controls

import "Common"

MenuBar {id: menuBar
    implicitHeight: 30
    delegate: MenuBarItem {
        id: menuBarItem
        implicitHeight: 30
        contentItem: D2RLFLabel {
            text: menuBarItem.text
            font: menuBarItem.font
            opacity: enabled ? 1.0 : 0.3
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }
}
