target_sources(${EXECUTABLE} PUBLIC  
	constants.c decode.c decode_ft8.c
	encode.c FT8_GUI.c FT8_main.c
	gen_ft8.c ldpc.c locator_ft8.c
	pack.c Process_DSP.c text.c
	traffic_manager.c unpack.c
)
