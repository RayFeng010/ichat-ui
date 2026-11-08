cmake_minimum_required(VERSION 3.16)

project(QianControls VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_OUTPUT_DIRECTORY  ${CMAKE_BINARY_DIR})

find_package(Qt6 6.8 COMPONENTS Quick REQUIRED)

# 添加包含目录 - 关键步骤
include_directories(
    FramelessWindow GifText
    ${CMAKE_CURRENT_BINARY_DIR} # 用于自动生成的moc文件
)

# Qian c++组件: 无边框窗口, gifText
# 注意: QIAN_CPP_FILES 不能放到 qt_add_qml_module 中, 否则不能自动注册到模块中
list(APPEND QIAN_CPP_FILES
    FramelessWindow/frameless_window.cc
    FramelessWindow/frameless_window.h
    GifText/giftext_handler.h
    GifText/giftext_handler.cc
)

# qml组件
list(APPEND QIAN_QML_MSG_FILES
    qmlQianHints/Message.qml            #顶部消息提示, 自动消失
    qmlQianHints/QianQuestionMark.qml
)

# 资源文件
list(APPEND QIAN_RES_FILES
    qmlQianHints/error.png
    qmlQianHints/questionMark.png
    qmlQianHints/questionMarkDarker.png
    qmlQianHints/remind.png
    qmlQianHints/true.png

)

if (MSVC)

    # message(STATUS "-----**********------- Qml -- Using MSVC compiler: ${CMAKE_C_COMPILER_ID}")

    #下面为了在vs ide中显示目录结构, QT中不需要
    source_group("Qml/Hints" FILES ${QIAN_QML_MSG_FILES})


endif()


# QianControls c++动态库
qt_add_library(QianControls STATIC
    ${QIAN_CPP_FILES}
)

# QML模块
qt_add_qml_module(QianControls
    URI QianControls
    VERSION 1.0
    QML_FILES   #QML文件列表
        ${QIAN_QML_MSG_FILES}
    RESOURCES   #资源文件列表
        ${QIAN_RES_FILES}
)

set_target_properties(QianControls PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(QianControls
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(QianControls PRIVATE
    Qt6::Qml
    Qt6::Quick
)

target_include_directories(QianControls PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

