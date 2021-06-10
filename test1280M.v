// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

module test1280M
(
// {ALTERA_ARGS_BEGIN} DO NOT REMOVE THIS LINE!

	FMCAclk40,
	led,
	pb,
	Tx_Data_out,
	FPGA_RESETn
// {ALTERA_ARGS_END} DO NOT REMOVE THIS LINE!

);

// {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
input			FMCAclk40;
output	[1:0]	led;
input	[1:0]	pb;
output	[15:0]	Tx_Data_out;
input			FPGA_RESETn;

// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_BEGIN} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_END} DO NOT REMOVE THIS LINE!

//////////////////////////////////////////////////
wire rst;
assign rst=!FPGA_RESETn;
wire FMCAclk40;
wire PLLClk160;
/////////////////////////////////////////////////////


wire clk_locked;	//PLL for FMCA

reg [127:0] tx_in;

genclktree genclktree_inst_0(

	.rst			(rst),
	.refclk		(FMCAclk40),
	.locked		(clk_locked),
	.outclk_0	(SerDes_Clk160),
	.outclk_1	(ref_clk40)

);
 
 serdesblock serdesblockInst
 (
	.tx_in(tx_in[127:0]),
   .tx_inclock(SerDes_Clk160),	//40MHz, synch w/ tx_in
	.pll_areset(rst),
	.tx_out(Tx_Data_out),
	.tx_coreclock(PLLClk160), //160 MHz, drives the serializer
	.tx_locked(clk_locked) 
	//.tx_outclock(tx_outclock)	//1.28GHz, synch w/ tx_out
 );
	
wire [127:0] ch1;
wire [127:0] ch2;
wire [127:0] ch3;
wire [127:0] ch4;

	
//below are the source instances
simple_counter simple_counter_inst0 (	//counter for source_gen: ch1	
	.clk160(PLLClk160),
	.counter_out(ch1) 
	);


prbs_source prbs_source_inst0 (	//prbs for source_gen: ch2
	.clk160(PLLClk160),
	.prbs_source(ch2)
);


const_source const_source_inst0 (
		.clk160(PLLClk160),
		.const(ch3),
		.const_bar(ch4)
);

//above are the source instances
////////////////////////////////////////////////////////

wire [1:0] pb;		//push button
wire [1:0] led;	//led

reg [127:0] data_out;
wire [127:0] logic_data;



source_gen source_gen_inst0 (
		.clk160(PLLClk160),
		.ch1(ch1),	//counter
		.ch2(ch2),	//prbs
		.ch3(ch3),	//const
		.ch4(ch4),	//const_bar
		.sel(to_led),	//selector from push button
		
		.indic(led),//indicators to led's
		.dout(logic_data)  //to FMCA[15:0]
);

always @(posedge PLLClk160)
begin
		data_out <= logic_data;
		tx_in <= data_out;
end



wire [1:0] to_led; //wire w_Switch1;
Debounce_Switch d_sw_inst0(
	.i_Clk(FMCAclk40), 
	.i_Switch(pb[0]), 
	.o_Switch(w_Switch_1[0])
	
);

Debounce_Switch d_sw_inst1(
	.i_Clk(FMCAclk40), 
	.i_Switch(pb[1]), 
	.o_Switch(w_Switch_1[1])
	
);

reg [1:0] r_LED_1 = 2'b00;
reg [1:0] r_Switch_1 = 2'b00;
wire [1:0] w_Switch_1;


always @(posedge PLLClk160)
  begin
    r_Switch_1 <= w_Switch_1;         // Creates a Register

    if (w_Switch_1[0] == 1'b0 && r_Switch_1[0] == 1'b1)
    begin
      r_LED_1[0] <= ~r_LED_1[0];         // Toggle LED output
    end
	 
	 if (w_Switch_1[1] == 1'b0 && r_Switch_1[1] == 1'b1)
    begin
      r_LED_1[1] <= ~r_LED_1[1];         // Toggle LED output
    end
  end
 
  assign to_led = r_LED_1;


endmodule
