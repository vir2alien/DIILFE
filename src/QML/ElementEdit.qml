import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "Common"
import "ElementEdit"

Item {id: elementEdit
    property bool elementEdited: false
    property int currentIndex: -1
    property string elementCode: ""
    property int editState: elementEdit.noneEdit
    readonly property int noneEdit: 0
    readonly property int codeEdit: 1
    readonly property int htmlEdit: 2

    onCurrentIndexChanged: {
        update();
    }
    Connections {id: htmlToDcodeEnable
        target: textEditor
        enabled: editState === elementEdit.htmlEdit
        function onTextChanged() {
            codeEditor.text = htmlToDcode(textEditor.text);
        }
    }
    Connections {id: dcodeToHtmlEnable
        target: codeEditor
        enabled: editState === elementEdit.codeEdit
        function onTextChanged() {
            textEditor.text = dcodeToHtml(codeEditor.text);
        }
    }

    function update() {
        if (currentIndex < 0) {
            return;
        }
        var item = elementListModel.get(currentIndex);
        elementCode = item.content;
        codeEditor.text = item.content.replace(/\n/g, '\\n');
        textEditor.text = dcodeToHtml(codeEditor.text);

        codeEditor.cursorPosition = 0;
        textEditor.cursorPosition = 0;
        codeEditor.focus = false;
        textEditor.focus = false;

        editState = noneEdit;
        elementEdited = false;
    }

    function saveElement() {
        let save_text = codeEditor.text.replace('\\n', '\n');
        let elements_item = elementListModel.get(currentIndex);
        elements_item.content = save_text;
        let filtered_object_item = filteredListModel.get(listView.currentIndex);
        filtered_object_item[elements_item.lang] = save_text;
        let id_object = filtered_object_item.id;
        for (let i = 0; i < listModel.count; i++) {
            if (listModel.get(i).id === id_object) {
                listModel.get(i)[elements_item.lang] = save_text;
                break;
            }
        }

        elementEdited = false;
        window.edited = true;
    }

    function dcodeToHtml(text) {
        let txt = text.split('\\n').join('<br>');
        txt = txt.split(' ').join('&nbsp;');
        txt = txt.replace(/\[.*?\]/g, '');
        let i = 0;
        let result = '';
        while (i < txt.length) {
            if (txt[i] === 'ÿ' && txt[i + 1] === 'c' && i + 2 < txt.length) {
                const code = 'ÿc' + txt[i + 2];
                const color_code = getColorCode(code);
                result += '<font color=\"' + color_code + '\">';
                i += 3;
            } else {
                result += txt[i];
                i += 1;
            }
        }
        return result;
    }
    function htmlToDcode(html) {
        let body_match = /<body[^>]*>([\s\S]*?)<\/body>/i.exec(html);
        if (!body_match || body_match.length < 2){
            return '';
        }
        let body_content = body_match[1];
        if (body_content.startsWith('\n')) {
            body_content = body_content.substring(1);
        }
        let text = body_content
            .replace(/<br \/>/gi, '\\n')
            .replace(/\\n+/g, '\\n');
        text = text.replace(/<span style="[^"]*color:(#[0-9a-fA-F]+);[^"]*">/gi,
                            (match, color) => getDcolorCode(color.toLowerCase())
                            );
        text = text.replace(/<\/span>/gi, '');
        text = text.replace(/<[^>]+>/g, '');
        return text;
    }

    function changeWidth(increase) {
        let str_arr = codeEditor.text.split('\\n');
        for (let i = 0; i < str_arr.length; i++) {
            if (increase) {
                if (str_arr[i].trim().length > 0) {
                    str_arr[i] = ' ' + str_arr[i] + ' ';
                }
            } else {
                if (str_arr[i][0] === ' ' && str_arr[i][str_arr[i].length - 1]  === ' ') {
                    str_arr[i] = str_arr[i].slice(1, -1);
                }
            }
        }
        codeEditor.text = str_arr.join('\\n');
        textEditor.text = dcodeToHtml(codeEditor.text);
    }
    function changeHeight(increase) {
        var str_arr = codeEditor.text.split('\\n');
        if (increase) {
            str_arr.unshift('');
            str_arr.push('');
        } else {
            if (str_arr.length > 1 && str_arr[0].trim().length === 0 && str_arr[str_arr.length - 1].trim().length === 0) {
                str_arr.shift();
                str_arr.pop();
            }
        }
        codeEditor.text = str_arr.join('\\n');
        textEditor.text = dcodeToHtml(codeEditor.text);
    }

    function insertColor(dcode) {
        if (editState === elementEdit.htmlEdit) {
            let plain_text = textEditor.getText(0, textEditor.length);
            let cursor_position = textEditor.cursorPosition;
            let i = 0;
            let new_cursor_position = 0;
            while (i < cursor_position) {
                if (codeEditor.text[new_cursor_position] === '\\') {
                    new_cursor_position = new_cursor_position + 2;
                    i = i + 1;
                } else if (codeEditor.text[new_cursor_position] === 'ÿ') {
                    new_cursor_position = new_cursor_position + 3;
                } else {
                    new_cursor_position = new_cursor_position + 1;
                    i = i + 1;
                }
            }
            codeEditor.insert(new_cursor_position, dcode);
            textEditor.text = dcodeToHtml(codeEditor.text);
        } else {
            codeEditor.insert(codeEditor.cursorPosition, dcode);
        }
    }

    FontLoader {id: diabloFontRu
        source: "qrc:/fonts/exocetblizzardot-medium.otf"
    }
    RowLayout {
        anchors.fill: parent
        spacing: 0
        GridLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: baseMargins
            Layout.rightMargin: baseMargins
            columns: 2
            rowSpacing: baseMargins*2
            D2RLFLabel {
                Layout.alignment: Qt.AlignTop
                text: qsTr("Код элемента: ")
            }
            D2RLFTextField {id: codeEditor
                Layout.alignment: Qt.AlignVCenter
                Layout.fillWidth: true
                onTextChanged: elementEdited = true
                onFocusChanged: {
                    if (focus) {
                        editState = elementEdit.codeEdit;
                    }
                }
            }//Text

            D2RLFLabel {
                Layout.alignment: Qt.AlignTop
                text: qsTr("Редактор: ")
            }
            TextArea {id: textEditor
                font.family: diabloFontRu.font.family
                font.pointSize: 16
                text: dcodeToHtml(codeEditor.text)
                color: "white"
                topPadding: bottomPadding
                leftPadding: 0
                rightPadding: 0
                textFormat: TextEdit.RichText
                background: Rectangle {
                    color: "#010101"
                }
                onTextChanged: elementEdited = true
                onFocusChanged: {
                    if (focus) {
                        editState = elementEdit.htmlEdit
                    }
                }
                Keys.onPressed: function(event) {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        if (!event.modifiers) {
                            event.accepted = true;
                            textEditor.insert(textEditor.cursorPosition, "<br>");
                        }
                    }
                }
            }//TextArea

            D2RLFHorisontalSeparator {
                Layout.fillWidth: true
                Layout.columnSpan: parent.columns
            }
            Item {
                Layout.columnSpan: parent.columns
                Layout.fillHeight: true
            }
        }//GridLayout

        D2RLFVerticalSeparator {
            Layout.fillHeight: true
        }

        ColumnLayout {
            Layout.minimumWidth: paletteBtn.width + baseMargins
            Layout.maximumWidth: paletteBtn.width + baseMargins
            Layout.preferredWidth: paletteBtn.width + baseMargins
            D2RLFMaterialButton {id: paletteBtn
                enabled: editState > noneEdit
                Layout.topMargin: parent.spacing
                Layout.alignment: Qt.AlignHCenter
                iconName: "palette"
                onClicked: coloPicker.open()
            }

            D2RLFHorisontalSeparator {
                Layout.fillWidth: true
            }

            D2RLFMaterialButton {
                Layout.alignment: Qt.AlignHCenter
                iconName: "open_in_full"
                onClicked: {
                    changeWidth(true);
                    changeHeight(true);
                }
            }
            D2RLFMaterialButton {
                Layout.alignment: Qt.AlignHCenter
                iconName: "swap_horiz"
                onClicked: changeWidth(true)
            }
            D2RLFMaterialButton {
                Layout.alignment: Qt.AlignHCenter
                iconName: "expand"
                onClicked: changeHeight(true)
            }

            D2RLFHorisontalSeparator {
                Layout.fillWidth: true
            }

            D2RLFMaterialButton {
                Layout.alignment: Qt.AlignHCenter
                iconName: "close_fullscreen"
                onClicked: {
                    changeHeight(false);
                    changeWidth(false);
                }
            }
            D2RLFMaterialButton {
                Layout.alignment: Qt.AlignHCenter
                iconName: "compare_arrows"
                onClicked: changeWidth(false)
            }
            D2RLFMaterialButton {
                Layout.alignment: Qt.AlignHCenter
                iconName: "compress"
                onClicked: changeHeight(false)
            }
            D2RLFHorisontalSeparator {
                Layout.fillWidth: true
            }

            D2RLFMaterialButton {
                enabled: elementEdited
                Layout.alignment: Qt.AlignHCenter
                iconName: "check_circle"
                onClicked: elementEdit.saveElement()
            }
            D2RLFMaterialButton {
                enabled: elementEdited
                Layout.alignment: Qt.AlignHCenter
                iconName: "cancel"
                onClicked: elementEdit.update()
            }
            D2RLFHorisontalSeparator {
                Layout.fillWidth: true
            }

            Item {
                Layout.fillHeight: true
            }
        }//ColumnLayout
    }//RowLayout

    ColorPopup {id: coloPicker
        x: parent.width - width - baseMargins/2
    }
}
