cmake_minimum_required(VERSION 3.14)
project(LZSS LANGUAGES C)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

message(STATUS "Install prefix: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "Install bindir: ${CMAKE_INSTALL_FULL_BINDIR}")
message(STATUS "Install libdir: ${CMAKE_INSTALL_FULL_LIBDIR}")
message(STATUS "Install includedir: ${CMAKE_INSTALL_FULL_INCLUDEDIR}")

set_source_files_properties(LZSS.C LZSS_encode.C PROPERTIES LANGUAGE C)

add_executable(LZSS LZSS.C)
add_library(LibLZSS STATIC LZSS_encode.C)
add_library(LZSS::LibLZSS ALIAS LibLZSS)

set_target_properties(LibLZSS PROPERTIES OUTPUT_NAME LZSS)
target_include_directories(LibLZSS PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

install(TARGETS LZSS LibLZSS
    EXPORT LZSSTargets
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)
install(FILES LibLZSS.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT LZSSTargets
    FILE LZSSTargets.cmake
    NAMESPACE LZSS::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/LZSS
)

configure_package_config_file(
    cmake/LZSSConfig.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/LZSSConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/LZSS
)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/LZSSConfig.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/LZSS
)

configure_file(cmake/LZSS.pc.in "${CMAKE_CURRENT_BINARY_DIR}/LZSS.pc" @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/LZSS.pc"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
)

add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND}
        -DMANIFEST=${CMAKE_BINARY_DIR}/install_manifest.txt
        -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake
    COMMENT "Uninstalling LZSS"
)
