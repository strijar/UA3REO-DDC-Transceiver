target_sources(${EXECUTABLE} PUBLIC  
	usbd_conf.c usbd_core.c usbd_ctlreq.c usbd_desc.c
	usb_device.c usbd_ioreq.c usbd_msc_bot.c usbd_msc_data.c
	usbd_msc_scsi.c
)
