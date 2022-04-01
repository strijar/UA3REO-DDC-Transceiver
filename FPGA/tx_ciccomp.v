// megafunction wizard: %FIR II v18.1%
// GENERATION: XML
// tx_ciccomp.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module tx_ciccomp (
		input  wire        clk,                //                     clk.clk
		input  wire        reset_n,            //                     rst.reset_n
		input  wire [23:0] ast_sink_data,      //   avalon_streaming_sink.data
		input  wire        ast_sink_valid,     //                        .valid
		input  wire [1:0]  ast_sink_error,     //                        .error
		input  wire        ast_sink_sop,       //                        .startofpacket
		input  wire        ast_sink_eop,       //                        .endofpacket
		output wire        ast_sink_ready,     //                        .ready
		output wire [47:0] ast_source_data,    // avalon_streaming_source.data
		output wire        ast_source_valid,   //                        .valid
		output wire [1:0]  ast_source_error,   //                        .error
		input  wire        ast_source_ready,   //                        .ready
		output wire        ast_source_sop,     //                        .startofpacket
		output wire        ast_source_eop,     //                        .endofpacket
		output wire [0:0]  ast_source_channel  //                        .channel
	);

	tx_ciccomp_0002 tx_ciccomp_inst (
		.clk                (clk),                //                     clk.clk
		.reset_n            (reset_n),            //                     rst.reset_n
		.ast_sink_data      (ast_sink_data),      //   avalon_streaming_sink.data
		.ast_sink_valid     (ast_sink_valid),     //                        .valid
		.ast_sink_error     (ast_sink_error),     //                        .error
		.ast_sink_sop       (ast_sink_sop),       //                        .startofpacket
		.ast_sink_eop       (ast_sink_eop),       //                        .endofpacket
		.ast_sink_ready     (ast_sink_ready),     //                        .ready
		.ast_source_data    (ast_source_data),    // avalon_streaming_source.data
		.ast_source_valid   (ast_source_valid),   //                        .valid
		.ast_source_error   (ast_source_error),   //                        .error
		.ast_source_ready   (ast_source_ready),   //                        .ready
		.ast_source_sop     (ast_source_sop),     //                        .startofpacket
		.ast_source_eop     (ast_source_eop),     //                        .endofpacket
		.ast_source_channel (ast_source_channel)  //                        .channel
	);

endmodule
// Retrieval info: <?xml version="1.0"?>
//<!--
//	Generated by Altera MegaWizard Launcher Utility version 1.0
//	************************************************************
//	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//	************************************************************
//	Copyright (C) 1991-2022 Altera Corporation
//	Any megafunction design, and related net list (encrypted or decrypted),
//	support information, device programming or simulation file, and any other
//	associated documentation or information provided by Altera or a partner
//	under Altera's Megafunction Partnership Program may be used only to
//	program PLD devices (but not masked PLD devices) from Altera.  Any other
//	use of such megafunction design, net list, support information, device
//	programming or simulation file, or any other related documentation or
//	information is prohibited for any other purpose, including, but not
//	limited to modification, reverse engineering, de-compiling, or use with
//	any other silicon devices, unless such use is explicitly licensed under
//	a separate agreement with Altera or a megafunction partner.  Title to
//	the intellectual property, including patents, copyrights, trademarks,
//	trade secrets, or maskworks, embodied in any such megafunction design,
//	net list, support information, device programming or simulation file, or
//	any other related documentation or information provided by Altera or a
//	megafunction partner, remains with Altera, the megafunction partner, or
//	their respective licensors.  No other licenses, including any licenses
//	needed under any third party's intellectual property, are provided herein.
//-->
// Retrieval info: <instance entity-name="altera_fir_compiler_ii" version="18.1" >
// Retrieval info: 	<generic name="filterType" value="single" />
// Retrieval info: 	<generic name="interpFactor" value="1" />
// Retrieval info: 	<generic name="decimFactor" value="1" />
// Retrieval info: 	<generic name="symmetryMode" value="sym" />
// Retrieval info: 	<generic name="L_bandsFilter" value="1" />
// Retrieval info: 	<generic name="inputChannelNum" value="2" />
// Retrieval info: 	<generic name="clockRate" value="188.160" />
// Retrieval info: 	<generic name="clockSlack" value="12" />
// Retrieval info: 	<generic name="inputRate" value="0.048" />
// Retrieval info: 	<generic name="coeffReload" value="false" />
// Retrieval info: 	<generic name="baseAddress" value="0" />
// Retrieval info: 	<generic name="readWriteMode" value="read_write" />
// Retrieval info: 	<generic name="backPressure" value="true" />
// Retrieval info: 	<generic name="deviceFamily" value="Cyclone IV E" />
// Retrieval info: 	<generic name="speedGrade" value="slow" />
// Retrieval info: 	<generic name="delayRAMBlockThreshold" value="-1" />
// Retrieval info: 	<generic name="dualMemDistRAMThreshold" value="-1" />
// Retrieval info: 	<generic name="mRAMThreshold" value="-1" />
// Retrieval info: 	<generic name="hardMultiplierThreshold" value="-1" />
// Retrieval info: 	<generic name="reconfigurable" value="false" />
// Retrieval info: 	<generic name="num_modes" value="2" />
// Retrieval info: 	<generic name="reconfigurable_list" value="0" />
// Retrieval info: 	<generic name="MODE_STRING" value="None Set" />
// Retrieval info: 	<generic name="channelModes" value="0,1,2,3" />
// Retrieval info: 	<generic name="inputType" value="int" />
// Retrieval info: 	<generic name="inputBitWidth" value="24" />
// Retrieval info: 	<generic name="inputFracBitWidth" value="0" />
// Retrieval info: 	<generic name="coeffSetRealValue" value="28.00554,-27.10925,19.67645,-4.287149,-19.57808,51.17337,-88.18982,126.592,-160.6796,183.3972,-186.9879,163.9282,-108.1905,16.62591,109.5636,-263.6392,432.4937,-596.6627,731.1469,-807.5047,796.876,-674.2095,422.8641,-39.60783,-461.3277,1045.19,-1656.29,2219.916,-2648.113,2848.07,-2734.149,2240.892,-1337.477,39.5772,1580.998,-3393.695,5212.197,-6807.6,7927.908,-8327.317,7798.005,-6206.687,3525.291,141.9623,-4547.706,9302.038,-13896.99,17744.61,-20239.07,20824.78,-19078.77,14781.87,-7986.836,-946.5419,11336.42,-22214.29,32386.79,-40551.05,45424.29,-45910.47,41249.44,-31171.23,15989.91,3331.081,-25211.26,47530.79,-67818.63,83470.12,-92052.68,91587.88,-80868.45,59674.43,-28961.77,-9123.589,51298.46,-93407.21,130739.5,-158539.0,172485.6,-169290.6,147135.8,-106120.4,48415.19,21657.19,-97925.23,172748.3,-237782.6,284718.8,-306310.4,297173.1,-254716.5,179607.6,-76220.19,-47582.81,180725.6,-309943.4,420748.9,-499073.1,532561.6,-512352.6,434111.3,-299329.1,115477.6,103682.6,-339223.7,567902.4,-764537.1,903717.5,-962954.8,924514.1,-778538.3,524056.0,-171261.8,-259125.4,734886.8,-1214970.0,1649588.0,-1984594.0,2161447.0,-2122105.0,1806062.0,-1152833.0,88736.87,1483707.0,-3739433.0,7013816.0,-1.203248E7,1.932583E7,1.932583E7,-1.203248E7,7013816.0,-3739433.0,1483707.0,88736.87,-1152833.0,1806062.0,-2122105.0,2161447.0,-1984594.0,1649588.0,-1214970.0,734886.8,-259125.4,-171261.8,524056.0,-778538.3,924514.1,-962954.8,903717.5,-764537.1,567902.4,-339223.7,103682.6,115477.6,-299329.1,434111.3,-512352.6,532561.6,-499073.1,420748.9,-309943.4,180725.6,-47582.81,-76220.19,179607.6,-254716.5,297173.1,-306310.4,284718.8,-237782.6,172748.3,-97925.23,21657.19,48415.19,-106120.4,147135.8,-169290.6,172485.6,-158539.0,130739.5,-93407.21,51298.46,-9123.589,-28961.77,59674.43,-80868.45,91587.88,-92052.68,83470.12,-67818.63,47530.79,-25211.26,3331.081,15989.91,-31171.23,41249.44,-45910.47,45424.29,-40551.05,32386.79,-22214.29,11336.42,-946.5419,-7986.836,14781.87,-19078.77,20824.78,-20239.07,17744.61,-13896.99,9302.038,-4547.706,141.9623,3525.291,-6206.687,7798.005,-8327.317,7927.908,-6807.6,5212.197,-3393.695,1580.998,39.5772,-1337.477,2240.892,-2734.149,2848.07,-2648.113,2219.916,-1656.29,1045.19,-461.3277,-39.60783,422.8641,-674.2095,796.876,-807.5047,731.1469,-596.6627,432.4937,-263.6392,109.5636,16.62591,-108.1905,163.9282,-186.9879,183.3972,-160.6796,126.592,-88.18982,51.17337,-19.57808,-4.287149,19.67645,-27.10925,28.00554" />
// Retrieval info: 	<generic name="coeffSetRealValueImag" value="0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -0.0530093, -0.04498, 0.0, 0.0749693, 0.159034, 0.224907, 0.249809, 0.224907, 0.159034, 0.0749693, 0.0, -0.04498, -0.0530093, -0.0321283, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0" />
// Retrieval info: 	<generic name="coeffScaling" value="auto" />
// Retrieval info: 	<generic name="coeffType" value="int" />
// Retrieval info: 	<generic name="coeffBitWidth" value="16" />
// Retrieval info: 	<generic name="coeffFracBitWidth" value="0" />
// Retrieval info: 	<generic name="coeffComplex" value="false" />
// Retrieval info: 	<generic name="karatsuba" value="false" />
// Retrieval info: 	<generic name="outType" value="int" />
// Retrieval info: 	<generic name="outMSBRound" value="trunc" />
// Retrieval info: 	<generic name="outMsbBitRem" value="0" />
// Retrieval info: 	<generic name="outLSBRound" value="trunc" />
// Retrieval info: 	<generic name="outLsbBitRem" value="0" />
// Retrieval info: 	<generic name="bankCount" value="1" />
// Retrieval info: 	<generic name="bankDisplay" value="0" />
// Retrieval info: </instance>
// IPFS_FILES : tx_ciccomp.vo
// RELATED_FILES: tx_ciccomp.v, dspba_library_package.vhd, dspba_library.vhd, auk_dspip_math_pkg_hpfir.vhd, auk_dspip_lib_pkg_hpfir.vhd, auk_dspip_avalon_streaming_controller_hpfir.vhd, auk_dspip_avalon_streaming_sink_hpfir.vhd, auk_dspip_avalon_streaming_source_hpfir.vhd, auk_dspip_roundsat_hpfir.vhd, altera_avalon_sc_fifo.v, tx_ciccomp_0002_rtl_core.vhd, tx_ciccomp_0002_ast.vhd, tx_ciccomp_0002.vhd
