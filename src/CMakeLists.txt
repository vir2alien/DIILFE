cmake_minimum_required(VERSION 3.16)
project(DIIRLootFilterEditor VERSION 0.5.0.0 LANGUAGES CXX)

# Настройки Qt и C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Поиск Qt6
find_package(Qt6 REQUIRED COMPONENTS Core Qml Quick QuickControls2)
qt_standard_project_setup()

# Версия приложения
add_compile_definitions(APP_VERSION="${PROJECT_VERSION}")

# Создание исполняемого файла
qt_add_executable(DIIRLootFilterEditor
    main.cpp
    filehandler.cpp filehandler.h
    qmlstyles.cpp qmlstyles.h
)

# Добавление ресурсов
qt_add_resources(DIIRLootFilterEditor "resources"
    PREFIX "/"
    FILES
        qml.qrc
        MaterialIcons/materialicons.qrc
        qtquickcontrols2.conf
)

qt_add_qml_module(DIIRLootFilterEditor
    URI DIIRLFE
    VERSION 1.0
    QML_FILES
        QML/Common/D2RLFLabel.qml
        QML/Common/D2RLFComboBox.qml
        QML/Common/D2RLFTextField.qml
        QML/Common/D2RLFMaterialIconLabel.qml
        QML/Common/D2RLFMaterialButton.qml
        QML/Common/D2RLFHorisontalSeparator.qml
        QML/Common/D2RLFVerticalSeparator.qml
        QML/Common/D2RLFMaterialIconButtonWithLabel.qml
        QML/Common/D2RLFInfoPopup.qml
        QML/ElementEdit.qml
        QML/ElementListView.qml
        QML/ObjectListView.qml
        QML/ObjectListView/LangSelectPopup.qml
        QML/MainMenu.qml
        QML/ElementEdit/ColorPopup.qml
)

# Линковка с Qt
target_link_libraries(DIIRLootFilterEditor
    PRIVATE Qt6::Core Qt6::Qml Qt6::Quick Qt6::QuickControls2
)

# Платформо-специфичные настройки
if(WIN32)
    set_target_properties(DIIRLootFilterEditor PROPERTIES WIN32_EXECUTABLE TRUE)
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/app.rc)
        target_sources(DIIRLootFilterEditor PRIVATE app.rc)
    endif()
endif()

# Финализация и деплой
qt_finalize_executable(DIIRLootFilterEditor)

# Установка
include(GNUInstallDirs)
install(TARGETS DIIRLootFilterEditor
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_app_script(
    TARGET DIIRLootFilterEditor
    OUTPUT_SCRIPT deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
)
install(SCRIPT ${deploy_script})

# CPack для Windows
if(WIN32)
    set(CPACK_GENERATOR "NSIS;ZIP")
    set(CPACK_PACKAGE_NAME "DIIRLootFilterEditor")
    set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION})
    include(CPack)
endif()
