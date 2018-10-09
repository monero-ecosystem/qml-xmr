cmake_minimum_required(VERSION 3.10)
project(qml-xmr)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)

find_package( Qt5LinguistTools )
find_package( Qt5Core 5.7 REQUIRED )
find_package( Qt5Quick 5.7 REQUIRED )
find_package( Qt5Widgets REQUIRED )
find_package( Qt5Gui REQUIRED )
find_package( Qt5Svg REQUIRED )
find_package( Qt5Network REQUIRED )
find_package( Qt5Xml REQUIRED )
find_package( Qt5XmlPatterns REQUIRED )
find_package( Qt5Qml REQUIRED )
find_package(OpenGL REQUIRED)

set(SOURCE_FILES
    main.cpp
    oscursor.cpp
)

include_directories(${OPENGL_INCLUDE_DIR})
include_directories(${Qt5Widgets_INCLUDES} ${Qt5Sql_INCLUDES}
        ${Qt5Svg_INCLUDES} ${Qt5Network_INCLUDES}
        ${Qt5Xml_INCLUDES} ${Qt5XmlPatterns_INCLUDES}
        ${Qt5PrintSupport_INCLUDES} ${Qt5Qml_INCLUDES})

add_definitions(${Qt5Widgets_DEFINITIONS} ${Qt5Sql_DEFINITIONS}
        ${Qt5Svg_DEFINITIONS} ${Qt5Network_DEFINITIONS}
        ${Qt5Xml_DEFINITIONS} ${Qt5XmlPatterns_DEFINITIONS}
        ${Qt5PrintSupport_DEFINITIONS} ${Qt5Qml_DEFINITIONS})

set(CMAKE_CXX_FLAGS "${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5Sql_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5Svg_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5Network_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5Xml_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5XmlPatterns_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5PrintSupport_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "-std=c++0x")

add_executable(qml-xmr ${SOURCE_FILES})

target_link_libraries(qml-xmr
    Qt5::Core
    Qt5::Quick
    Qt5::Widgets
    Qt5::Gui
)

SET(CMAKE_INSTALL_PREFIX /usr/local/bin/)

install(TARGETS qml-xmr
        DESTINATION ${CMAKE_INSTALL_PREFIX}
        )
