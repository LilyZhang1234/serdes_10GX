//constant source for source_gen
//value for const: 0x3C5C; value for const_bar: 0xC3A3

module const_source(
		input clk160,
		output reg [127:0] const,
		output reg [127:0] const_bar
);


always @ (posedge clk160) begin
	//const = 16'h001f;			//const
	//const_bar = 16'hffe0;	//const_bar
	const = {64{2'b00}};
	const = {64{2'b11}};

end 


endmodule