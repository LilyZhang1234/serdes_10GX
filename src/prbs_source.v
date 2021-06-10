//prbs source for source gen
//taken from the 10GX1280Mprbs project

//prbs source for source gen
//taken from the 10GX1280Mprbs project



module prbs_source(
	input clk160,
	output [127:0] prbs_source
);


reg [126:0] prbs71=127'b1111_1110_1010_1001_1001_1101_1101_0010_1100_0110_111101101011011001001000111000010111110010101110011010001001111000101000011000001000000;// PRBS created from right to left, b0^b1==b7

always @(posedge clk160)
begin
	   prbs71[126:0]<={prbs71[7:0], prbs71[126:8]};
end

assign prbs_source = {prbs71[0],prbs71};

endmodule
