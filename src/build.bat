@echo off

REM Создание директории сборки
if not exist build mkdir build
cd build

REM Конфигурация (укажите путь к Qt6)
cmake .. ^
    -G "MinGW Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH=C:/Qt/6.x.x/mingw_64 ^
    -DCMAKE_INSTALL_PREFIX=C:/Program Files/DIIRLootFilterEditor

REM Сборка
cmake --build . --config Release

REM Создание установщика
cmake --build . --target package