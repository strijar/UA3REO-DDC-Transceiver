cls
cppcheck . --cppcheck-build-dir=.cppcheck --enable=all --force --platform=unix32 --suppressions-list=.cppcheck-suppressions -UFRONTPANEL_BIG_V1 -UFRONTPANEL_LITE -UFRONTPANEL_LITE_V2_MINI -UFRONTPANEL_MINI -UFRONTPANEL_NONE -UFRONTPANEL_SMALL_V1 -UFRONTPANEL_WF_100D -UFRONTPANEL_X1 -ULAY_320x240 -USTM32F407xx -ULCD_HX8357B -ULCD_HX8357C -ULCD_ILI9341 -ULCD_ILI9481 -ULCD_ILI9486 -ULCD_NONE -ULCD_ST7735S -ULCD_ST7789 -ULCD_ILI9481_IPS -ULCD_SLOW 2> cppcheck-errors.txt