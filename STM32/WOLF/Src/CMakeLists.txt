target_sources(${EXECUTABLE} PUBLIC  
	fatfs.c fpga.c front_unit.c hardware.c
	lcd.c main.c rf_unit.c stm32h7xx_hal_msp.c
	stm32h7xx_it.c system_stm32h7xx.c user_diskio.c
)
