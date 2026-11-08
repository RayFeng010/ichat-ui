cmake_minimum_required(VERSION 3.28)

#cmd: cmake ..  -G "Visual Studio 17" -DCMAKE_INSTALL_PREFIX="D:\project-qt\study\chapter10-2-iChat-ui\build\Install"
#qt参数: -DCMAKE_INSTALL_PREFIX="D:\project-qt\study\chapter10-2-iChat-ui\build\Install"

project ("iChat-ui" VERSION 0.0.1 LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2 Multimedia)

qt_standard_project_setup(REQUIRES 6.8)

set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOMOC ON)

cmake_policy(SET CMP0067 NEW) 
set (CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_SHARED_LINKER_FLAGS "-Wl,-Bsymbolic")
cmake_policy(SET CMP0141 NEW)


# qml ui文件路径
# file(REAL_PATH "../Qml" LIB_PATH BASE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

# # qml ui文件 qml_files
file(GLOB_RECURSE  qml_files Qml/*)
foreach(qml IN LISTS qml_files)
    get_filename_component(qml_name ${qml} NAME)
    set_source_files_properties(${qml} PROPERTIES
        QT_RESOURCE_ALIAS ${qml_name}
    )
endforeach()

# 设置 QML 导入路径（所有子目录都将被包含）
list(APPEND QML_IMPORT_PATHS "${LIB_PATH}")
set(QML_IMPORT_PATH "${QML_IMPORT_PATHS}" CACHE STRING "Qt Creator QML import paths")

# 资源文件 pic gif等 app_resources
file(GLOB_RECURSE  app_resources Resources/*)
foreach(res IN LISTS app_resources)
    file(RELATIVE_PATH res_name ${CMAKE_CURRENT_SOURCE_DIR}/Resources ${res})
    set_source_files_properties(${res} PROPERTIES
        QT_RESOURCE_ALIAS ${res_name}
    )
endforeach()

# 关键：将 emoji 目录复制到构建目录
# file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/Resources/emoji
#      DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
# )


#消除js文件引入告警问题
list(APPEND QIAN_JS_FILES
    Qml/Bubble/BubbleBlack.js
    Qml/Bubble/BubbleBlue.js
    Qml/Bubble/BubbleBlueWhite.js
    Qml/Bubble/BubbleNormal.js
)

set_source_files_properties(
    ${QIAN_JS_FILES}
    PROPERTIES
    QT_QML_SKIP_QMLDIR_ENTRY TRUE  # 防止重复评估
    #QT_RESOURCE_ALIAS "scripts/utils.js"  # 明确资源别名
)


if (MSVC)

    # message(STATUS "-----**********------- Qml -- Using MSVC compiler: ${CMAKE_C_COMPILER_ID}")
    
    #下面为了在vs ide中显示目录结构, QT中不需要
    source_group("AppResources" FILES ${app_resources})


endif()

# IDE中文件分类
source_group("" FILES ${APP_SOURCES})


# qml ui与对应的cpp源码
set(APP_SOURCES
    #frameless_window.h frameless_window.cpp #无边框window
    #giftext_handler.h giftext_handler.cpp #gif 文本处理
    )

# 添加子目录
add_subdirectory(QianControls)
add_subdirectory(RelaxControls)

#执行文件
qt_add_executable(iChat-ui
    main.cpp
    ${APP_SOURCES}
)

# Set QML import path
list(APPEND CMAKE_MODULE_PATH ${CMAKE_INSTALL_PREFIX}/qml)  # 修改为实际的安装路径
target_compile_definitions(iChat-ui PRIVATE QML_IMPORT_PATH="${QML_IMPORT_PATH}")


# 添加qml模块
qt_add_qml_module(iChat-ui
    URI MyApp
    VERSION 1.0
    RESOURCES ${app_resources} ${QIAN_JS_FILES}
    QML_FILES ${qml_files}
    #${QML_MAIN_FILES} ${QML_MIDDLE_FILES} ${QML_RIGHT_FILES} ${QML_COMMON_FILES} ${QML_Dialog_FILES}

)


# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(iChat-ui PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.iChat-ui
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)


target_link_libraries(iChat-ui PRIVATE
    #Qian::QuickKit #改用QianControls
    Qt6::Quick
    Qt6::Core
    Qt6::QuickControls2
    Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS iChat-ui
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
