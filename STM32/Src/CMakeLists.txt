target_sources(${EXECUTABLE} PUBLIC  
	adpcm-lib.c agc.c atu.c	audio_filters.c	audio_processor.c auto_calibration.c
	auto_notch.c bands.c bootloader.c callsign.c codec.c codec_nau8822.c
	codec_wm8731.c cw.c cw_decoder.c decoder.c events.c fft.c filemanager.c
	fonts.c functions.c i2c.c images.c INA226_PWR_monitor.c lcd_driver.c
	lcd_driver_ILI9341.c lcd_driver_ILI9481.c lcd_driver_NONE.c lcd_driver_RA8875.c
	lcd_driver_ST7735S.c lcd_driver_ST7789.c locator.c
	noise_blanker.c noise_reduction.c pre_distortion.c profiler.c
	rds_decoder.c RFFC2071.c rtty_decoder.c satellite.c
	screen_layout_160x128.cpp screen_layout_320x240.cpp
	screen_layout_480x320.cpp screen_layout_800x480.cpp
	sd.c self_test.c settings.c snap.c spec_analyzer.c swr_analyzer.c
	system_menu.c touchpad.c touchpad_GT911.c trx_manager.c
	usbd_audio_if.c usbd_cat_if.c usbd_debug_if.c usbd_iq_if.c
	usbd_storage_if.c usbd_ua3reo.c vad.c vocoder.c
	wifi.c wspr.c
)

add_subdirectory(BiquadDesigner)
add_subdirectory(FT8)
add_subdirectory(JPEG)
add_subdirectory(USBDevice)
