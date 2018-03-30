cmake_minimum_required(VERSION 2.6)
project(flexandbison)

find_package(BISON)
find_package(FLEX)

message("FLEX_FOUND: ${FLEX_FOUND}")
message("FLEX_EXECUTABLE: ${FLEX_EXECUTABLE}")
message("FLEX_VERSION: ${FLEX_VERSION}")
message("FLEX_LIBRARIES: ${FLEX_LIBRARIES}")
message("FLEX_INCLUDE_DIRS: ${FLEX_INCLUDE_DIRS}")

#add_custom_command(OUTPUT snazzle.cpp
#		   COMMAND "/usr/bin/flex snazzle.l -o snazzle.cpp")
flex_target(snazzle_scanner snazzle.l "${CMAKE_CURRENT_BINARY_DIR}/snazzle_scanner.cpp")

include_directories("${CMAKE_CURRENT_BINARY_DIR}")

add_executable(flexandbison ${FLEX_snazzle_scanner_OUTPUTS})
target_link_libraries(flexandbison fl)

install(TARGETS flexandbison RUNTIME DESTINATION bin)
