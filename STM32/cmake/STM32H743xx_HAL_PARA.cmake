set(linker_script_SRC ${PROJ_PATH}/WOLF/GCC/STM32H743VITX_FLASH.ld)

set(compiler_define ${compiler_define}
    "USE_HAL_DRIVER"
    "STM32H743xx"
    "ARM_MATH_MATRIX_CHECK"
    "ARM_MATH_ROUNDING"
    "ARM_MATH_LOOPUNROLL"
)
