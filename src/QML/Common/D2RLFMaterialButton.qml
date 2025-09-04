import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import "qrc:/MaterialIconsMapping.js" as MaterialIcons

Button {id: control
    property string iconName: ""
    property int iconSize: buttonIconSize
    property string toolTipText: ""
    implicitWidth: height
    topPadding: 0
    bottomPadding: 0
    leftPadding: 0
    //width: height
    topInset: 0
    bottomInset: 0
    padding: 0
    rightPadding: text.length > 0 ? 2 : 0
    flat: true
    contentItem: Label {id: icon
        anchors.fill: parent
        visible: control.iconName.length > 0
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: materialFont.name
        font.pointSize: control.iconSize
        text: MaterialIcons.Icon[control.iconName] ? MaterialIcons.Icon[iconName] : ""
        color: !enabled ? Material.hintTextColor :
                          checked || highlighted ? "white" : Material.accentColor
    }
    FontLoader {id: materialFont
        source: "qrc:/MaterialIcons-Regular.ttf"
    }
}
