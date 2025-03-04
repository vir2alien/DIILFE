import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import "qrc:/Common"

Dialog {id: control
    property int baseHeight: (header?header.height:0) + (footer?footer.height:0) + padding*2
    property bool borderSeparator: false
    property string infoText: ""
    property int type: D2RLFInfoPopup.Type.Info
    enum Type {
        Info,
        Error
    }
    modal: true
    x: (parent.width - width)/2
    y: (parent.height - height)/2
    width: 400
    height: baseHeight + textLabel.height
    title: {
        switch (control.type) {
        case D2RLFInfoPopup.Type.Info: return "Информация";
        case D2RLFInfoPopup.Type.Error: return "Ошибка";
        }
    }

    header: D2RLFLabel {
        text: control.title
        visible: control.title
        elide: D2RLFLabel.ElideRight
        font.bold: true
        padding: 12
        background: Rectangle {
            x: 1; y: 1
            width: parent.width - 2
            height: parent.height - 1
            color: control.palette.window
        }
    }
    D2RLFLabel {id: textLabel
        text: infoText
    }

    footer: DialogButtonBox {
        buttonLayout: DialogButtonBox.AndroidLayout
        Button {id: buttonOk
            text: qsTr("Ок")
            flat: true
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
            onClicked: control.close();
        }
    }
}
