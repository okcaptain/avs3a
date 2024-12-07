cmake_minimum_required(VERSION 3.1)

set(LIBNAME av3ad)
project(${LIBNAME})

set(CMAKE_C_STANDARD 99)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include_directories(.)
include_directories("include")
include_directories("src")
aux_source_directory(./src SRC)

if("${PROJECT_ABI}" MATCHES "aarch64" OR
        "${PROJECT_ABI}" MATCHES "arm64")
    add_definitions(-D _arm64)
elseif("${PROJECT_ABI}" MATCHES "^arm")
    add_definitions(-D _armv7a)
endif()

add_definitions(-lstdc++ -lm -ldl -llog)
add_definitions(-fsigned-char)

set (CONFIG_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)
set(prefix "${CMAKE_INSTALL_PREFIX}")
set(includedir "include")
set(libdir "lib")
set(CMAKE_INSTALL_INCLUDE_DIR "${CMAKE_INSTALL_PREFIX}/${includedir}")
set(CMAKE_INSTALL_LIB_DIR "${CMAKE_INSTALL_PREFIX}/${libdir}")
set(CMAKE_INSTALL_PKGCONFIG_DIR "${CMAKE_INSTALL_LIB_DIR}/pkgconfig")
set(pc_file "${CONFIG_DIR}/${LIBNAME}.pc")
file(WRITE "${pc_file}" "prefix=${prefix}\n")
file(APPEND "${pc_file}" "exec_prefix=\${prefix}\n")
file(APPEND "${pc_file}" "includedir=\${prefix}/${includedir}\n")
file(APPEND "${pc_file}" "libdir=\${exec_prefix}/${libdir}\n\n")
file(APPEND "${pc_file}" "Name: ${LIBNAME}\n")
file(APPEND "${pc_file}" "Description: AVS3-A decoder\n")
file(APPEND "${pc_file}" "Version: 1.0\n")
file(APPEND "${pc_file}" "Requires:\n")
file(APPEND "${pc_file}" "Conflicts:\n")
if(CMAKE_USE_PTHREADS_INIT)
  file(APPEND "${pc_file}" "Libs: -L\${libdir} -l${LIBNAME} -lm -lpthread\n")
else()
  file(APPEND "${pc_file}" "Libs: -L\${libdir} -l${LIBNAME} -lm\n")
file(APPEND "${pc_file}" "Libs.private:\n")
endif()
file(APPEND "${pc_file}" "Cflags: -I\${includedir}\n")
add_library(${LIBNAME}  ${SRC})

if (NOT MSVC)
    target_link_libraries(${LIBNAME} m)
endif()
if(CMAKE_USE_PTHREADS_INIT)
    target_link_libraries(${LIBNAME} pthread)
endif()

install(TARGETS av3ad LIBRARY DESTINATION ${CMAKE_INSTALL_LIB_DIR} ARCHIVE DESTINATION ${CMAKE_INSTALL_LIB_DIR})
install(FILES include/decoder.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_cnst_com.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_const_meta.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_dec_lib.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_decoder_interface.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_options.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_prot_com.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_prot_dec.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_rom_com.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_stat_com.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_stat_dec.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/avs3_stat_meta.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES include/Instruction.h  DESTINATION  ${CMAKE_INSTALL_INCLUDE_DIR})
install(FILES ${CONFIG_DIR}/${LIBNAME}.pc  DESTINATION  ${CMAKE_INSTALL_PKGCONFIG_DIR})
