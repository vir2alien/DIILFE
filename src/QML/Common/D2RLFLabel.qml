import QtQuick
import QtQuick.Controls

Label {
    renderType: Qt.platform.os === "windows"// && enabled
                    ? Text.NativeRendering
                    : Text.QtRendering
    font.pointSize: fontBody1
    elide: Label.ElideRight
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Label.AlignLeft
}
