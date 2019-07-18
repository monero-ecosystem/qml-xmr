cmake_minimum_required(VERSION 3.10)
project(qml-xmr)

set(DEBUG ON)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_CXX_FLAGS "-fPIC")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
# set(CMAKE_AUTORCC ON) # we dynamically compile & load RCC at runtime
set(CMAKE_AUTOUIC ON)

if(NOT DEFINED CMAKE_PREFIX_PATH)
	message("WARNING: You should invoke cmake with -DCMAKE_PREFIX_PATH to specify the path to Qt5.")

	if(APPLE)
		set(CMAKE_PREFIX_PATH $ENV{HOME}/Qt/5.9.7/clang_64)
	elseif(LINUX)
		set(CMAKE_PREFIX_PATH $ENV{HOME}/Qt/5.9.7/gcc_64)
	endif()

	message("Setting CMAKE_PREFIX_PATH to: ${CMAKE_PREFIX_PATH} (this might not exist)")
endif()

set(OPENSSL_ROOT_DIR /usr/local/opt/openssl)
set(SOURCE_FILES
    src/oscursor.h
    src/oscursor.cpp
    src/livereload.h
    src/livereload.cpp
    src/utils.h
    src/utils.cpp
    src/window.h
    src/window.cpp
    src/mocks/Wallet.h
    src/mocks/NetworkType.h
    main.cpp
	src/mocks/QrcMock.cpp 
	src/mocks/QrcMock.h 
	src/mocks/clipboard.cpp 
	src/mocks/clipboard.h)

add_executable(qml-xmr ${SOURCE_FILES})

find_package(Qt5Core REQUIRED)
find_package(Qt5Quick REQUIRED)
find_package(Qt5Widgets REQUIRED)
find_package(Qt5Gui REQUIRED)
find_package(Qt5Network REQUIRED)
find_package(Qt5Qml REQUIRED)
find_package(Qt5Multimedia REQUIRED)
find_package(Qt5Xml REQUIRED)
find_package(Qt5XmlPatterns REQUIRED)
find_package(Qt5Svg REQUIRED)

target_include_directories(qml-xmr PUBLIC ${Qt5Gui_PRIVATE_INCLUDE_DIRS})

find_package(OpenGL REQUIRED)

# OpenSSL
find_package(OpenSSL REQUIRED)
target_include_directories(qml-xmr PUBLIC ${OPENSSL_INCLUDE_DIR})
message(STATUS "OpenSSL: Version ${OPENSSL_VERSION}")
message(STATUS "OpenSSL: include dir at ${OPENSSL_INCLUDE_DIR}")
message(STATUS "OpenSSL: libraries at ${OPENSSL_LIBRARIES} ${OPENSSL_SSL_LIBRARIES}")

include_directories(${OPENGL_INCLUDE_DIR})
include_directories(${OPENSSL_INCLUDE_DIR})
message("Qt5Network include dirs found: ${Qt5Network_INCLUDE_DIRS}")

set(CMAKE_CXX_FLAGS "${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5Sql_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5Svg_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5Network_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5Xml_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5XmlPatterns_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "${Qt5PrintSupport_EXECUTABLE_COMPILE_FLAGS}")
set(CMAKE_CXX_FLAGS "-std=c++0x")

set(LINK_LIBS)
if (APPLE)
	list(APPEND LINK_LIBS "-framework CoreGraphics -framework QuartzCore -framework AudioToolbox -framework OpenAL -framework Foundation -framework CoreFoundation -framework CoreServices -framework IOKit -framework AppKit")
else()

endif()

target_link_libraries(qml-xmr
	${LINK_LIBS}
	${OPENSSL_LIBRARIES}
	${OPENSSL_SSL_LIBRARIES}
	pthread
	Qt5::Core
	Qt5::Quick
	Qt5::Widgets
	Qt5::Gui
	Qt5::Network
	Qt5::Qml
	Qt5::Multimedia
	Qt5::Xml
	Qt5::XmlPatterns
	Qt5::Svg
)

SET(CMAKE_INSTALL_PREFIX /usr/local/bin/)

install(TARGETS qml-xmr
        DESTINATION ${CMAKE_INSTALL_PREFIX}
        )
