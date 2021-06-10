//Example of simple 32-bit up counter
//Single clock input and 32-bit output port


module simple_counter (
	input clk160,
	output [127:0] counter_out 
	);

reg [127:0] data = {64{2'b01}};
	
always @ (posedge clk160)
	begin
		data <= ~data; //001f=all one, ffe0 is all zero
     end
	
assign counter_out = data;


endmodule
