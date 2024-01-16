cmake_minimum_required(VERSION 3.22)

list(APPEND CMAKE_MODULE_PATH       "${CMAKE_CURRENT_LIST_DIR}/cmake")

set(CMAKE_C_STANDARD                11)
set(CMAKE_C_STANDARD_REQUIRED       ON)
set(CMAKE_C_EXTENSIONS              ON)
set(CMAKE_CXX_STANDARD              17)
set(CMAKE_CXX_STANDARD_REQUIRED     ON)
set(CMAKE_CXX_EXTENSIONS            ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS	ON)
set(PROJ_PATH                       ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_TOOLCHAIN_FILE			gcc-arm-none-eabi)

project(WOLF_RA8875_GT911)
enable_language(C CXX ASM)

set(EXECUTABLE ${CMAKE_PROJECT_NAME})

include(STM32H743xx_HAL_PARA)
include(RA8875_GT911)

add_executable(${EXECUTABLE})

include_directories(Src)
include_directories(Src/BiquadDesigner)
include_directories(Src/FT8)
include_directories(Src/JPEG)
include_directories(Src/USBDevice)
include_directories(WOLF/Inc)
include_directories(WOLF/Drivers/CMSIS/Device/ST/STM32H7xx/Include)
include_directories(WOLF/Drivers/CMSIS/Include)
include_directories(WOLF/Drivers/STM32H7xx_HAL_Driver/Inc)
include_directories(WOLF/Drivers/STM32H7xx_HAL_Driver/Inc/Legacy)
include_directories(WOLF/Middlewares/Third_Party/CMSIS-DSP/Include)
include_directories(WOLF/Middlewares/Third_Party/CMSIS-DSP/Include/dsp)
include_directories(WOLF/Middlewares/Third_Party/CMSIS-DSP/PrivateInclude)
include_directories(WOLF/Middlewares/Third_Party/FatFs/src)
include_directories(WOLF/MDK-ARM/RTE/_RA8875_GT911)

add_subdirectory(WOLF)
add_subdirectory(Src)

target_link_libraries(${EXECUTABLE} PRIVATE CMSISDSP c m nosys)
target_compile_definitions(${EXECUTABLE} PRIVATE ${HAL} ${DEVICE})

add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
	COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${EXECUTABLE}>
)

set(SECTIONS -j .isr_vector -j .text -j .rodata -j .ARM.extab -j .ARM -j .preinit_array -j .init_array -j .fini_array -j .data)

add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
	COMMAND ${CMAKE_OBJCOPY} ${SECTIONS} -O ihex $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.hex
)

add_custom_command(TARGET ${EXECUTABLE} POST_BUILD
	COMMAND ${CMAKE_OBJCOPY} ${SECTIONS} -O binary $<TARGET_FILE:${EXECUTABLE}> ${EXECUTABLE}.bin
)