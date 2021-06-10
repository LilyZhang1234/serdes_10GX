module serdesblock (
		input  wire [127:0] tx_in,        //        tx_in.export
		output wire [15:0]  tx_out,       //       tx_out.export
		output wire         tx_coreclock, // tx_coreclock.export
		input  wire         tx_inclock,   //      inclock.export
		input  wire         pll_areset,   //   pll_areset.export
		output wire         tx_locked     //   pll_locked.export
	);
endmodule

