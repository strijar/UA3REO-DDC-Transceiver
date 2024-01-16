set(CMAKE_SYSTEM_NAME               Generic)
set(CMAKE_SYSTEM_PROCESSOR          arm)

set(CPU                             -mcpu=cortex-m7 -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb)
set(TOOLCHAIN_PREFIX                arm-none-eabi-)

set(CMAKE_C_COMPILER                ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER              ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER              ${TOOLCHAIN_PREFIX}g++)
set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PREFIX}objcopy)
set(CMAKE_SIZE                      ${TOOLCHAIN_PREFIX}size)

set(CMAKE_EXECUTABLE_SUFFIX_ASM     ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX     ".elf")

set(LINKER_SCRIPT                   ${CMAKE_CURRENT_SOURCE_DIR}/WOLF/GCC/STM32H743VITX_FLASH.ld)

add_compile_options(${CPU} -fdata-sections -ffunction-sections -Ofast -g)
add_link_options(${CPU} --specs=nosys.specs -T${LINKER_SCRIPT} -Wl,--gc-sections -Wl,--print-memory-usage)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
