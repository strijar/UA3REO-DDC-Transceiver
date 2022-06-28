#include "hardware.h"
#include "functions.h"
#include "main.h"

void HRDW_Init(void) {
		HAL_ADCEx_InjectedStart(&hadc1); // ADC RF-UNIT'а
		#ifdef FRONTPANEL_X1
		HAL_ADCEx_InjectedStart(&hadc2); //ADC Tangent (some versions)
		#endif
		HAL_ADCEx_InjectedStart(&hadc3); // ADC CPU temperature
}

float32_t HRDW_getCPUTemperature(void)
{
	//STM32H743 Temperature
	uint16_t TS_CAL1 = *((uint16_t *)0x1FF1E820); // TS_CAL1 Temperature sensor raw data acquired value at 30 °C, VDDA=3.3 V //-V566
	uint16_t TS_CAL2 = *((uint16_t *)0x1FF1E840); // TS_CAL2 Temperature sensor raw data acquired value at 110 °C, VDDA=3.3 V //-V566
	uint32_t TS_DATA = HAL_ADCEx_InjectedGetValue(&hadc3, ADC_INJECTED_RANK_1);
	float32_t result = ((110.0f - 30.0f) / ((float32_t)TS_CAL2 - (float32_t)TS_CAL1)) * ((float32_t)TS_DATA - (float32_t)TS_CAL1) + 30; // from reference
	return result;
}

float32_t HRDW_getCPUVref(void)
{
	//STM32H743 VREF
	uint16_t VREFINT_CAL = *VREFINT_CAL_ADDR; // VREFIN_CAL Raw data acquired at temperature of 30 °C, VDDA = 3.3 V //-V566
	uint32_t VREFINT_DATA = HAL_ADCEx_InjectedGetValue(&hadc3, ADC_INJECTED_RANK_2);
	float32_t result = 3.3f * (float32_t)VREFINT_CAL / (float32_t)VREFINT_DATA; // from reference
	return result;
}

uint32_t HRDW_getAudioCodecRX_DMAIndex(void) {
	return CODEC_AUDIO_BUFFER_SIZE - (uint16_t)__HAL_DMA_GET_COUNTER(hi2s3.hdmarx);
}

uint32_t HRDW_getAudioCodecTX_DMAIndex(void) {
	return CODEC_AUDIO_BUFFER_SIZE * 2 - (uint16_t)__HAL_DMA_GET_COUNTER(hi2s3.hdmatx);
}

bool HRDW_FrontUnit_SPI(uint8_t *out_data, uint8_t *in_data, uint16_t count, bool hold_cs) {
	return SPI_Transmit(&hspi2, out_data, in_data, 3, AD1_CS_GPIO_Port, AD1_CS_Pin, hold_cs, SPI_FRONT_UNIT_PRESCALER, false);
}

bool HRDW_FrontUnit2_SPI(uint8_t *out_data, uint8_t *in_data, uint16_t count, bool hold_cs) {
	return SPI_Transmit(&hspi2, out_data, in_data, 3, AD2_CS_GPIO_Port, AD2_CS_Pin, hold_cs, SPI_FRONT_UNIT_PRESCALER, false);
}

bool HRDW_FrontUnit3_SPI(uint8_t *out_data, uint8_t *in_data, uint16_t count, bool hold_cs) {
	return SPI_Transmit(&hspi2, out_data, in_data, 3, AD3_CS_GPIO_Port, AD3_CS_Pin, hold_cs, SPI_FRONT_UNIT_PRESCALER, false);
}

bool HRDW_EEPROM_SPI(uint8_t *out_data, uint8_t *in_data, uint16_t count, bool hold_cs) {
	return SPI_Transmit(&hspi2, out_data, in_data, 3, W25Q16_CS_GPIO_Port, W25Q16_CS_Pin, hold_cs, SPI_EEPROM_PRESCALER, false);
}

bool HRDW_SD_SPI(uint8_t *out_data, uint8_t *in_data, uint16_t count, bool hold_cs) {
	return SPI_Transmit(&hspi2, out_data, in_data, 3, SD_CS_GPIO_Port, SD_CS_Pin, hold_cs, SPI_SD_PRESCALER, false);
}
