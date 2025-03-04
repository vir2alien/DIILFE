import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

import DIIRLFE 1.0

import "qrc:/Common"

ApplicationWindow {id: window
    visible: true
    width: 800
    height: 600

    property string currentLang: "enUS"
    property bool edited: false
    property bool loaded: false
    property string error: ""

    readonly property int baseMargins: 8
    readonly property int buttonIconSize: 20
    readonly property int fontBody1: 11
    readonly property int fontBody2: 10
    readonly property int fontHeader: 20
    readonly property int fontBUTTON: 11

    readonly property int delegateHeight: Material.delegateHeight

    readonly property var langCodes: [
        "enUS", "zhTW", "deDE", "esES", "frFR", "itIT",
        "koKR", "plPL", "esMX", "jaJP", "ptBR", "ruRU", "zhCN"
    ]
    readonly property var langNames: [
        "English (US)", "臺灣話", "Deutsch", "Español (EU)", "Français", "Italiano",
        "한국어", "Polski", "Español (Latino)", "日本語", "Português (Brasil)", "Русский", "繁體中文"
    ]
    readonly property var colorCodes: [
        ["ÿc1"], ["ÿc2", "ÿcQ"], ["ÿc3", "ÿcB"], ["ÿc4", "ÿc>", "ÿcD"],
        ["ÿc5"], ["ÿc6", "ÿcM"], ["ÿc7"], ["ÿc8", "ÿc@", "ÿcJ", "ÿcL"],
        ["ÿc9", "ÿc?"], ["ÿc0"], ["ÿc;"], ["ÿc:", "ÿcA"],
        ["ÿc<"], ["ÿcC"], ["ÿcE", "ÿcF", "ÿcG", "ÿcH", "ÿc="], ["ÿcI", "ÿcK"],
        ["ÿcN"], ["ÿcO"], ["ÿcP"], ["ÿcR"],
        ["ÿcS"], ["ÿcT"], ["ÿcU"]
    ]
    readonly property var colorValues: [
        "#ff5151", "#01ff01", "#7171ff", "#c9b57a",
        "#6d6d6d", "#010101", "#d1c480", "#ffaa01",
        "#ffff68", "#ffffff", "#b001ff", "#018301",
        "#01ca01", "#01fc01", "#f0f0f0", "#676767",
        "#08a8de", "#ff83ff", "#acacff", "#ffff79",
        "#d14242", "#85c7ff", "#ff0101"
    ]
    Component.onCompleted: {
        langListModel.createModel();
        colorListModel.createModel();
        if (!fileHangler.fileExists(appSettings.currentFile)) {
            return;
        }
        var json_text = fileHangler.readFile(appSettings.currentFile);
        if (!setJson(listModel, json_text) || !setJson(filteredListModel, json_text)) {
            return;
        }
        window.loaded = true;
    }

    onErrorChanged: {
        if (error.length > 0) {
            errorPopup.infoText = error;
            errorPopup.open();
        }
    }

    function loadFile(selectedFile) {
        window.loaded = false;
        if (!fileHangler.fileExists(selectedFile)) {
            return;
        }
        edited = false;
        appSettings.currentFile = selectedFile;
        var json_text = fileHangler.readFile(selectedFile);
        if (!setJson(listModel, json_text) || !setJson(filteredListModel, json_text)) {
            return;
        }
        listView.currentIndex = -1;
        elementListView.currentIndex = -1;
        window.loaded = true;
    }

    function getColorCode(dcode) {
        for (let i = 0; i < colorCodes.length; i++) {
            const c_arr = colorCodes[i];
            for (let j = 0; j < c_arr.length; j++) {
                if (dcode === colorCodes[i][j]) {
                    return colorValues[i];
                }
            }
        }
        return "#ffffff";
    }
    function getDcolorCode(color) {
        for (let i = 0; i < colorValues.length; i++) {
            if (colorValues[i] === color) {
                return colorCodes[i][0];
            }
        }
        return "";
    }

    function setJson(model, json_text) {
        model.clear();
        let json_data;
        try {
            json_data = JSON.parse(json_text);
        } catch (e) {
            window.error = e.toString();
            return false;
        }
        if (json_data.length === 0) {
            window.error = "Json parse error";
            return false;
        }
        let test_json = json_data[0];
        if (!test_json.hasOwnProperty("id") || !test_json.hasOwnProperty("Key")) {
            window.error = "Json parse error";
            return false;
        }

        for (var i = 0; i < json_data.length; i++) {
            model.append ({
                id: json_data[i].id,
                Key: json_data[i].Key,
                enUS: json_data[i].enUS,
                zhTW: json_data[i].zhTW,
                deDE: json_data[i].deDE,
                esES: json_data[i].esES,
                frFR: json_data[i].frFR,
                itIT: json_data[i].itIT,
                koKR: json_data[i].koKR,
                plPL: json_data[i].plPL,
                esMX: json_data[i].esMX,
                jaJP: json_data[i].jaJP,
                ptBR: json_data[i].ptBR,
                ruRU: json_data[i].ruRU,
                zhCN: json_data[i].zhCN
            });
        }
        return true;
    }

    function getJson(model) {
        var json_array = [];
        for (var i = 0; i < model.count; i++) {
            var item = model.get(i);
            var json_item = {};
            for (var prop in item) {
                if (prop !== "index") {
                    json_item[prop] = item[prop];
                }
            }
            json_array.push(json_item);
        }
        return JSON.stringify(json_array, null, 2);
    }

    FileHandler {id: fileHangler

    }

    Settings {id: appSettings
        property alias x: window.x
        property alias y: window.y
        property alias width: window.width
        property alias height: window.height
        property alias defaultLang: window.currentLang
        property var currentFile
    }

    ListModel {id: colorListModel
        function createModel() {
            for (let i = 0; i < colorCodes.length; i++) {
                colorListModel.append({dcode: colorCodes[i][0], cvalue: colorValues[i]});
            }
        }
    }
    ListModel {id: langListModel
        function createModel() {
            for (let i = 0; i < langCodes.length; i++) {
                langListModel.append({value: langCodes[i], text: langNames[i]});
            }
        }
    }

    ListModel {id: listModel

    }
    ListModel {id: filteredListModel
        function updateFilter(search_text) {
            filteredListModel.clear();
            listView.currentIndex = -1;
            for (let i = 0; i < listModel.count; i++) {
                const item = listModel.get(i);
                for (var prop in item) {
                    if (prop === "index") {
                        continue;
                    }
                    var itemdata = String(item[prop]).toLowerCase();
                    var serarchdata = String(search_text).toLowerCase();
                    if (itemdata.includes(serarchdata)) {
                        filteredListModel.append(item);
                        break;
                    }
                }
            }
        }
    }
    ListModel {id: elementListModel
    }
    header: Flow {
        leftPadding: baseMargins
        height: openButton.height + baseMargins/2
        width: parent.width
        Row {id: fileRow
            D2RLFMaterialButton { id: openButton
                iconName: "file_open"
                onClicked: openFileDialog.open()
            }
            D2RLFMaterialButton {
                enabled: edited
                iconName: "save"
                onClicked: {
                    fileHangler.writeFile(appSettings.currentFile, getJson(listModel));
                    edited = false;
                }
            }
            D2RLFMaterialButton {
                enabled: loaded
                iconName: "save_as"
                onClicked: saveFileDialog.open()
            }
            ToolSeparator {
                height: parent.height
            }
        }
    }

    D2RLFHorisontalSeparator {
        anchors.top: parent.top
        width: window.width
    }

    RowLayout {
        spacing: 0
        anchors.fill: parent
        ObjectListView {id: listView
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            clip: true
            model: filteredListModel
            textRole: currentLang
            onFilterTextChanged: filteredListModel.updateFilter(filterText)
            onCurrentIndexChanged: {
                elementListView.updateModel(currentIndex);
                elementEdit.update();
            }
        }
        D2RLFVerticalSeparator {
            Layout.fillHeight: true
        }
        ElementListView {id: elementListView
            visible: listView.currentIndex > -1
            Layout.preferredWidth: 300
            Layout.maximumWidth: 300
            Layout.fillHeight: true
            clip: true
        }

        D2RLFVerticalSeparator {
            visible: listView.currentIndex > -1
            Layout.fillHeight: true
        }
        ElementEdit {id: elementEdit
            visible: elementListView.currentIndex > -1 && listView.currentIndex > -1
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.leftMargin: baseMargins
            currentIndex: elementListView.currentIndex
        }
        Item {
            visible: elementListView.currentIndex < 0
            Layout.fillWidth: true
        }
    }

    FileDialog {id: openFileDialog
        title: "Выберите JSON файл"
        nameFilters: ["JSON Files (*.json)"]
        fileMode: FileDialog.OpenFile
        onAccepted: loadFile(selectedFile);
    }
    FileDialog {id: saveFileDialog
        title: "Сохранить как..."
        nameFilters: ["JSON Files (*.json)"]
        fileMode: FileDialog.SaveFile
        onAccepted: {
            fileHangler.writeFile(selectedFile, getJson(listModel));
        }
    }

    D2RLFInfoPopup {id: errorPopup
        type: D2RLFInfoPopup.Type.Error
        onAccepted: {
            window.error = "";
        }
        onClosed: {
            window.error = "";
        }
    }
}
