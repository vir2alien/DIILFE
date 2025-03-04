import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "qrc:/MaterialIconsMapping.js" as MaterialIcons

Label {id: control
    property string iconName: ""
    property int iconSize: 20
    property bool highlighted : false
    property int radius: iconSize
    width: height
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    color: highlighted ? Material.backgroundColor : Material.iconColor
    background: Rectangle {
        radius: control.radius
        color: highlighted ? Material.iconColor : Material.backgroundColor
    }
    font.family: materialFont.name
    font.pointSize: iconSize
    //font.pixelSize: iconSize
    text: iconName ? MaterialIcons.Icon[iconName] : ""
    FontLoader {id: materialFont
        source: "qrc:/MaterialIcons-Regular.ttf"
    }
}
