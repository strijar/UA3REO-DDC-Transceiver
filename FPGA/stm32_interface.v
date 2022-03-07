module stm32_interface(
clk_in,
RX1_I,
RX1_Q,
RX2_I,
RX2_Q,
DATA_SYNC,
ADC_OTR,
DAC_OTR,
ADC_IN,
ADC_RAW,
adcclk_in,
FLASH_data_in,
FLASH_busy,
VCXO_error,
BUS_SPI_data_in,
BUS_SPI_busy,
spi_clk,
iq_clk,

DATA_BUS,
NCO1_freq,
preamp_enable,
rx1,
tx,
TX_I,
TX_Q,
reset_n,
stage_debug,
FLASH_data_out,
FLASH_enable,
FLASH_continue_read,
ADC_PGA,
ADC_RAND,
ADC_SHDN,
ADC_DITH,
unused,
CICFIR_GAIN,
TX_CICFIR_GAIN,
DAC_GAIN,
ADC_OFFSET,
NCO2_freq,
rx2,
tx_iq_valid,
VCXO_correction,
DAC_div0,
DAC_div1,
DAC_hp1,
DAC_hp2,
DAC_x4,
DCDC_freq,
TX_NCO_freq,
RX_CIC_RATE,
IQ_RX_READ_REQ,
IQ_RX_READ_CLK,
DAC_DRV_A0,
DAC_DRV_A1,
BUS_SPI_data_out,
BUS_SPI_enable,
BUS_SPI_Stage
);

input clk_in;
input signed [31:0] RX1_I;
input signed [31:0] RX1_Q;
input signed [31:0] RX2_I;
input signed [31:0] RX2_Q;
input DATA_SYNC;
input ADC_OTR;
input DAC_OTR;
input signed [15:0] ADC_IN;
input signed [15:0] ADC_RAW;
input adcclk_in;
input unsigned [7:0] FLASH_data_in;
input unsigned [31:0] BUS_SPI_data_in;
input FLASH_busy;
input signed [23:0] VCXO_error;
input BUS_SPI_busy;
input spi_clk;
input iq_clk;

output reg unsigned [31:0] NCO1_freq = 242347;
output reg unsigned [31:0] NCO2_freq = 242347;
output reg unsigned [31:0] TX_NCO_freq = 242347;
output reg preamp_enable = 0;
output reg rx1 = 1;
output reg rx2 = 0;
output reg tx = 0;
output reg reset_n = 1;
output reg signed [31:0] TX_I = 'd0;
output reg signed [31:0] TX_Q = 'd0;
output reg [15:0] stage_debug = 0;
output reg unsigned [7:0] FLASH_data_out = 0;
output reg FLASH_enable = 0;
output reg FLASH_continue_read = 0;
output reg ADC_PGA = 0;
output reg ADC_RAND = 0;
output reg ADC_SHDN = 1;
output reg ADC_DITH = 0;
output reg unused = 0;
output reg IQ_RX_READ_REQ = 0;
output reg IQ_RX_READ_CLK = 0;
output reg unsigned [7:0] CICFIR_GAIN = 32;
output reg unsigned [7:0] TX_CICFIR_GAIN = 32;
output reg unsigned [7:0] DAC_GAIN = 32;
output reg signed [15:0] ADC_OFFSET = 'd0;
output reg tx_iq_valid = 0;
output reg signed [7:0] VCXO_correction = 'd0;
output reg DAC_div0 = 0;
output reg DAC_div1 = 0;
output reg DAC_hp1 = 0;
output reg DAC_hp2 = 0;
output reg DAC_x4 = 0;
output reg DCDC_freq = 0;
output reg DAC_DRV_A0 = 1;
output reg DAC_DRV_A1 = 1;
output reg unsigned [10:0] RX_CIC_RATE = 'd640;
output reg unsigned [31:0] BUS_SPI_data_out = 0;
output reg BUS_SPI_enable = 0;
output reg unsigned [7:0] BUS_SPI_Stage = 'd0;

inout [3:0] DATA_BUS;
reg   [3:0] DATA_BUS_OUT;
reg         DATA_BUS_OE; // 1 - out 0 - in
assign DATA_BUS = DATA_BUS_OE ? DATA_BUS_OUT : 4'bZ ;

reg signed [15:0] k = 'd1;
reg signed [15:0] ADC_MIN;
reg signed [15:0] ADC_MAX;
reg signed [31:0] READ_RX1_I;
reg signed [31:0] READ_RX1_Q;
reg ADC_MINMAX_RESET;
reg sync_reset_n = 1;
reg unsigned [3:0] BUS_TEST;

always @ (posedge clk_in)
begin
	//начало передачи
	if (DATA_SYNC == 1)
	begin
		DATA_BUS_OE = 0;
		ADC_MINMAX_RESET = 0;
		FLASH_continue_read = 0;
		
		if(DATA_BUS[3:0] == 'd0) //BUS TEST
		begin
			k = 500;
		end
		else if(DATA_BUS[3:0] == 'd1) //GET PARAMS
		begin
			k = 100;
		end
		else if(DATA_BUS[3:0] == 'd2) //SEND PARAMS
		begin
			DATA_BUS_OE = 1;
			k = 200;
		end
		else if(DATA_BUS[3:0] == 'd3) //TX IQ
		begin
			tx_iq_valid = 0;
			k = 300;
		end
		else if(DATA_BUS[3:0] == 'd5) //RESET ON
		begin
			sync_reset_n = 0;
			k = 999;
		end
		else if(DATA_BUS[3:0] == 'd6) //RESET OFF
		begin
			sync_reset_n = 1;
			k = 999;
		end
		else if(DATA_BUS[3:0] == 'd7) //FPGA FLASH READ
		begin
			FLASH_enable = 0;
			k = 700;
		end
		else if(DATA_BUS[3:0] == 'd8) //GET INFO
		begin
			DATA_BUS_OE = 1;
			k = 800;
		end
	end
	else if (k == 100) //GET PARAMS
	begin
		rx1 = DATA_BUS[0:0];
		rx2 = DATA_BUS[1:1];
		tx = DATA_BUS[2:2];
		ADC_DITH = DATA_BUS[3:3];
		if(tx == 0) //clear TX chain
		begin
			TX_I[31:0] = 32'd0;
			TX_Q[31:0] = 32'd0;
			tx_iq_valid = 1;
		end
		k = 101;
	end
	else if (k == 101) //GET PARAMS
	begin
		ADC_SHDN = DATA_BUS[0:0];
		ADC_RAND = DATA_BUS[1:1];
		ADC_PGA = DATA_BUS[2:2];
		preamp_enable = DATA_BUS[3:3];
		k = 102;
	end
	else if (k == 102)
	begin
		NCO1_freq[31:28] = DATA_BUS[3:0];
		k = 103;
	end
		else if (k == 103)
	begin
		NCO1_freq[27:24] = DATA_BUS[3:0];
		k = 104;
	end
	else if (k == 104)
	begin
		NCO1_freq[23:20] = DATA_BUS[3:0];
		k = 105;
	end
	else if (k == 105)
	begin
		NCO1_freq[19:16] = DATA_BUS[3:0];
		k = 106;
	end
	else if (k == 106)
	begin
		NCO1_freq[15:12] = DATA_BUS[3:0];
		k = 107;
	end
	else if (k == 107)
	begin
		NCO1_freq[11:8] = DATA_BUS[3:0];
		k = 108;
	end
	else if (k == 108)
	begin
		NCO1_freq[7:4] = DATA_BUS[3:0];
		k = 109;
	end
	else if (k == 109)
	begin
		NCO1_freq[3:0] = DATA_BUS[3:0];
		k = 110;
	end
	else if (k == 110)
	begin
		NCO2_freq[31:28] = DATA_BUS[3:0];
		k = 111;
	end
	else if (k == 111)
	begin
		NCO2_freq[27:24] = DATA_BUS[3:0];
		k = 112;
	end
	else if (k == 112)
	begin
		NCO2_freq[23:20] = DATA_BUS[3:0];
		k = 113;
	end
	else if (k == 113)
	begin
		NCO2_freq[19:16] = DATA_BUS[3:0];
		k = 114;
	end
	else if (k == 114)
	begin
		NCO2_freq[15:12] = DATA_BUS[3:0];
		k = 115;
	end
	else if (k == 115)
	begin
		NCO2_freq[11:8] = DATA_BUS[3:0];
		k = 116;
	end
	else if (k == 116)
	begin
		NCO2_freq[7:4] = DATA_BUS[3:0];
		k = 117;
	end
	else if (k == 117)
	begin
		NCO2_freq[3:0] = DATA_BUS[3:0];
		k = 118;
	end
	else if (k == 118)
	begin
		CICFIR_GAIN[7:4] = DATA_BUS[3:0];
		k = 119;
	end
	else if (k == 119)
	begin
		CICFIR_GAIN[3:0] = DATA_BUS[3:0];
		k = 120;
	end
	else if (k == 120)
	begin
		TX_CICFIR_GAIN[7:4] = DATA_BUS[3:0];
		k = 121;
	end
	else if (k == 121)
	begin
		TX_CICFIR_GAIN[3:0] = DATA_BUS[3:0];
		k = 122;
	end
	else if (k == 122)
	begin
		DAC_GAIN[7:4] = DATA_BUS[3:0];
		k = 123;
	end
	else if (k == 123)
	begin
		DAC_GAIN[3:0] = DATA_BUS[3:0];
		k = 124;
	end
	else if (k == 124)
	begin
		ADC_OFFSET[15:12] = DATA_BUS[3:0];
		k = 125;
	end
	else if (k == 125)
	begin
		ADC_OFFSET[11:8] = DATA_BUS[3:0];
		k = 126;
	end
	else if (k == 126)
	begin
		ADC_OFFSET[7:4] = DATA_BUS[3:0];
		k = 127;
	end
	else if (k == 127)
	begin
		ADC_OFFSET[3:0] = DATA_BUS[3:0];
		k = 128;
	end
	else if (k == 128)
	begin
		VCXO_correction[7:4] = DATA_BUS[3:0];
		k = 129;
	end
	else if (k == 129)
	begin
		VCXO_correction[3:0] = DATA_BUS[3:0];
		k = 130;
	end
	else if (k == 130)
	begin
		DAC_div0 = DATA_BUS[0:0];
		DAC_div1 = DATA_BUS[1:1];
		DAC_hp1 = DATA_BUS[2:2];
		DAC_hp2 = DATA_BUS[3:3];
		k = 131;
	end
	else if (k == 131)
	begin
		DAC_x4 = DATA_BUS[0:0];
		DCDC_freq = DATA_BUS[1:1];
		
		if(DATA_BUS[3:2] =='d0)
			RX_CIC_RATE = 'd160;
		else if(DATA_BUS[3:2] =='d1)
			RX_CIC_RATE = 'd320;
		else if(DATA_BUS[3:2] =='d2)
			RX_CIC_RATE = 'd640;
		else if(DATA_BUS[3:2] =='d3)
			RX_CIC_RATE = 'd1280;
			
		k = 132;
	end
	else if (k == 132)
	begin
		TX_NCO_freq[31:28] = DATA_BUS[3:0];
		k = 133;
	end
	else if (k == 133)
	begin
		TX_NCO_freq[27:24] = DATA_BUS[3:0];
		k = 134;
	end
	else if (k == 134)
	begin
		TX_NCO_freq[23:20] = DATA_BUS[3:0];
		k = 135;
	end
	else if (k == 135)
	begin
		TX_NCO_freq[19:16] = DATA_BUS[3:0];
		k = 136;
	end
	else if (k == 136)
	begin
		TX_NCO_freq[15:12] = DATA_BUS[3:0];
		k = 137;
	end
	else if (k == 137)
	begin
		TX_NCO_freq[11:8] = DATA_BUS[3:0];
		k = 138;
	end
	else if (k == 138)
	begin
		TX_NCO_freq[7:4] = DATA_BUS[3:0];
		k = 139;
	end
	else if (k == 139)
	begin
		TX_NCO_freq[3:0] = DATA_BUS[3:0];
		k = 140;
	end
	else if (k == 140)
	begin
		DAC_DRV_A0 = DATA_BUS[0:0];
		DAC_DRV_A1 = DATA_BUS[1:1];
		k = 999;
	end
	else if (k == 200) //SEND PARAMS
	begin
		DATA_BUS_OUT[0:0] = ADC_OTR;
		DATA_BUS_OUT[1:1] = DAC_OTR;
		k = 201;
	end
	else if (k == 201)
	begin
		DATA_BUS_OUT[3:0] = ADC_MIN[15:12];
		k = 202;
	end
	else if (k == 202)
	begin
		DATA_BUS_OUT[3:0] = ADC_MIN[11:8];
		k = 203;
	end
	else if (k == 203)
	begin
		DATA_BUS_OUT[3:0] = ADC_MIN[7:4];
		k = 204;
	end
	else if (k == 204)
	begin
		DATA_BUS_OUT[3:0] = ADC_MIN[3:0];
		k = 205;
	end
	else if (k == 205)
	begin
		DATA_BUS_OUT[3:0] = ADC_MAX[15:12];
		k = 206;
	end
	else if (k == 206)
	begin
		DATA_BUS_OUT[3:0] = ADC_MAX[11:8];
		k = 207;
	end
	else if (k == 207)
	begin
		DATA_BUS_OUT[3:0] = ADC_MAX[7:4];
		ADC_MINMAX_RESET=1;
		k = 208;
	end
	else if (k == 208)
	begin
		DATA_BUS_OUT[3:0] = ADC_MAX[3:0];
		ADC_MINMAX_RESET=1;
		k = 209;
	end
	else if (k == 209)
	begin
		DATA_BUS_OUT[3:0] = VCXO_error[23:20];
		k = 210;
	end
	else if (k == 210)
	begin
		DATA_BUS_OUT[3:0] = VCXO_error[19:16];
		k = 211;
	end
	else if (k == 211)
	begin
		DATA_BUS_OUT[3:0] = VCXO_error[15:12];
		k = 212;
	end
	else if (k == 212)
	begin
		DATA_BUS_OUT[3:0] = VCXO_error[11:8];
		k = 213;
	end
	else if (k == 213)
	begin
		DATA_BUS_OUT[3:0] = VCXO_error[7:4];
		k = 214;
	end
	else if (k == 214)
	begin
		DATA_BUS_OUT[3:0] = VCXO_error[3:0];
		k = 215;
	end
	else if (k == 215)
	begin
		DATA_BUS_OUT[3:0] = ADC_RAW[15:12];
		k = 216;
	end
	else if (k == 216)
	begin
		DATA_BUS_OUT[3:0] = ADC_RAW[11:8];
		k = 217;
	end
	else if (k == 217)
	begin
		DATA_BUS_OUT[3:0] = ADC_RAW[7:4];
		k = 218;
	end
	else if (k == 218)
	begin
		DATA_BUS_OUT[3:0] = ADC_RAW[3:0];
		k = 999;
	end
	else if (k == 300) //TX IQ
	begin
		TX_Q[31:28] = DATA_BUS[3:0];
		k = 301;
	end
	else if (k == 301)
	begin
		TX_Q[27:24] = DATA_BUS[3:0];
		k = 302;
	end
	else if (k == 302)
	begin
		TX_Q[23:20] = DATA_BUS[3:0];
		k = 303;
	end
	else if (k == 303)
	begin
		TX_Q[19:16] = DATA_BUS[3:0];
		k = 304;
	end
	else if (k == 304)
	begin
		TX_Q[15:12] = DATA_BUS[3:0];
		k = 305;
	end
	else if (k == 305)
	begin
		TX_Q[11:8] = DATA_BUS[3:0];
		k = 306;
	end
	else if (k == 306)
	begin
		TX_Q[7:4] = DATA_BUS[3:0];
		k = 307;
	end
	else if (k == 307)
	begin
		TX_Q[3:0] = DATA_BUS[3:0];
		k = 308;
	end
	else if (k == 308)
	begin
		TX_I[31:28] = DATA_BUS[3:0];
		k = 309;
	end
	else if (k == 309)
	begin
		TX_I[27:24] = DATA_BUS[3:0];
		k = 310;
	end
	else if (k == 310)
	begin
		TX_I[23:20] = DATA_BUS[3:0];
		k = 311;
	end
	else if (k == 311)
	begin
		TX_I[19:16] = DATA_BUS[3:0];
		k = 312;
	end
	else if (k == 312)
	begin
		TX_I[15:12] = DATA_BUS[3:0];
		k = 313;
	end
	else if (k == 313)
	begin
		TX_I[11:8] = DATA_BUS[3:0];
		k = 314;
	end
	else if (k == 314)
	begin
		TX_I[7:4] = DATA_BUS[3:0];
		k = 315;
	end
	else if (k == 315)
	begin
		TX_I[3:0] = DATA_BUS[3:0];
		tx_iq_valid = 1;
		k = 999;
	end
	else if (k == 500) //BUS TEST
	begin
		BUS_TEST[3:0] = DATA_BUS[3:0];
		k = 501;
	end
	else if (k == 501)
	begin
		DATA_BUS_OE = 1;
		DATA_BUS_OUT[3:0] = BUS_TEST[3:0];
		k = 500;
	end
	else if (k == 700) //FPGA FLASH READ - SEND COMMAND
	begin
		DATA_BUS_OE = 0;
		FLASH_data_out[7:4] = DATA_BUS[3:0];
		k = 701;
	end
	else if (k == 701)
	begin
		DATA_BUS_OE = 0;
		FLASH_data_out[3:0] = DATA_BUS[3:0];
		if(FLASH_enable == 0)
			FLASH_enable = 1;
		else
			FLASH_continue_read = 1;
		k = 702;
	end
	else if (k == 702) //FPGA FLASH READ - READ ANSWER
	begin
		DATA_BUS_OE = 1;
		if(FLASH_busy)
			DATA_BUS_OUT[3:0] = 'd15;
		else
			DATA_BUS_OUT[3:0] = FLASH_data_in[7:4];
		k = 703;
	end
	else if (k == 703)
	begin
		FLASH_continue_read = 0;
		if(FLASH_busy)
			DATA_BUS_OUT[3:0] = 'd15;
		else
			DATA_BUS_OUT[3:0] = FLASH_data_in[3:0];
		k = 700;
	end
	else if (k == 800) //GET INFO
	begin
		DATA_BUS_OUT[3:0] = 'd0; //flash id 1
		k = 801;
	end
	else if (k == 801) //GET INFO
	begin
		DATA_BUS_OUT[3:0] = 'd3;
		k = 802;
	end
	else if (k == 802)
	begin
		DATA_BUS_OUT[3:0] = 'd0; //flash id 2
		k = 803;
	end
	else if (k == 803)
	begin
		DATA_BUS_OUT[3:0] = 'd5;
		k = 804;
	end
	else if (k == 804)
	begin
		DATA_BUS_OUT[3:0] = 'd0; //flash id 3
		k = 805;
	end
	else if (k == 805)
	begin
		DATA_BUS_OUT[3:0] = 'd0;
		k = 999;
	end
	stage_debug=k;
end

always @ (posedge adcclk_in)
begin
	//ADC MIN-MAX
	if(ADC_MINMAX_RESET == 1)
	begin
		ADC_MIN = 'd32000;
		ADC_MAX = -16'd32000;
	end
	if(ADC_MAX<ADC_IN)
	begin
		ADC_MAX=ADC_IN;
	end
	if(ADC_MIN>ADC_IN)
	begin
		ADC_MIN=ADC_IN;
	end
end

always @ (negedge adcclk_in)
begin
	//RESET SYNC
	reset_n = sync_reset_n;
end

always @ (posedge spi_clk)
begin
	//BUS SPI
	if(BUS_SPI_Stage == 0 && iq_clk == 1) //start RX1 I
	begin
		IQ_RX_READ_REQ = 1;
		IQ_RX_READ_CLK = 1;
		READ_RX1_I[31:0] = RX1_I[31:0];
		READ_RX1_Q[31:0] = RX1_Q[31:0];
		//
		BUS_SPI_data_out[31:0] = READ_RX1_I[31:0];
		BUS_SPI_enable = 1;
		BUS_SPI_Stage = 1;
	end
	else if(BUS_SPI_Stage == 1) //wait spi
	begin
		BUS_SPI_enable = 1;
		if(BUS_SPI_busy == 1)
			BUS_SPI_Stage = 2;
	end
	else if(BUS_SPI_Stage == 2 && BUS_SPI_busy == 0) //end RX1 I
	begin
		IQ_RX_READ_CLK = 0;
		//
		BUS_SPI_enable = 0;
		BUS_SPI_Stage = 3;
	end
	else if(BUS_SPI_Stage == 3) //start RX1 Q
	begin
		BUS_SPI_data_out[31:0] = READ_RX1_Q[31:0];
		BUS_SPI_enable = 1;
		BUS_SPI_Stage = 4;
	end
	else if(BUS_SPI_Stage == 4 && BUS_SPI_busy == 1) //wait spi
	begin
		BUS_SPI_Stage = 5;
	end
	else if(BUS_SPI_Stage == 5 && BUS_SPI_busy == 0) //end RX1 Q
	begin
		BUS_SPI_enable = 0;
		BUS_SPI_Stage = 6;
	end
	else if(BUS_SPI_Stage == 6 && iq_clk == 0) //wait iq clk end
	begin
		BUS_SPI_Stage = 0;
	end
end

endmodule
