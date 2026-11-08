cmake_minimum_required(VERSION 3.21)

project(RelaxControls VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR})

find_package(Qt6 6.8 COMPONENTS Core Quick Multimedia REQUIRED)

# 添加包含目录 - 关键步骤
include_directories(
    Clipboard Audio RichText
    ${CMAKE_CURRENT_BINARY_DIR} # 用于自动生成的moc文件
)

#CPP源文件
list(APPEND RELAX_CPP_FILES
    Clipboard/clipboard_helper.cc
    Clipboard/clipboard_helper.h
    Audio/audio_level_worker.h
    Audio/audio_level_worker.cc
    Audio/audio_manager.h
    Audio/audio_manager.cc
    RichText/rich_text_handler.h
    RichText/rich_text_handler.cc
)

#生成动态库
qt_add_library(RelaxControls SHARED
    ${RELAX_CPP_FILES}
)

#添加qml的模块
qt_add_qml_module(RelaxControls
    URI RelaxControls
    VERSION 1.0
    QML_FILES MyItemControls.qml
    SOURCES myitem.cpp myitem.h
)

set_target_properties(RelaxControls PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(RelaxControls
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(RelaxControls PRIVATE
    Qt6::Quick
    Qt6::Qml
    Qt6::Core
    Qt6::QuickControls2
    Qt6::Multimedia
)

target_include_directories(RelaxControls PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

