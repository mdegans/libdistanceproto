CMAKE_MINIMUM_REQUIRED(VERSION 3.10)

PROJECT(distanceproto CXX)
SET(CMAKE_CXX_STANDARD 11)

# get version from file
FILE(READ "VERSION" DISTANCEPROTO_VERSION_STRING)

# https://stackoverflow.com/questions/18658233/split-string-to-3-variables-in-cmake
STRING(REPLACE "." ";" VERSION_LIST ${DISTANCEPROTO_VERSION_STRING})
LIST(GET VERSION_LIST 0 DISTANCEPROTO_VERSION_MAJOR)
LIST(GET VERSION_LIST 1 DISTANCEPROTO_VERSION_MINOR)
LIST(GET VERSION_LIST 2 DISTANCEPROTO_VERSION_PATCH)

MESSAGE("${PROJECT_NAME} version: ${DISTANCEPROTO_VERSION_MAJOR}.${DISTANCEPROTO_VERSION_MINOR}.${DISTANCEPROTO_VERSION_PATCH}")

ADD_SUBDIRECTORY(src)
