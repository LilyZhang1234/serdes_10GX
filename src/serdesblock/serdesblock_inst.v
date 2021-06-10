	serdesblock u0 (
		.tx_in        (_connected_to_tx_in_),        //   input,  width = 128,        tx_in.export
		.tx_out       (_connected_to_tx_out_),       //  output,   width = 16,       tx_out.export
		.tx_coreclock (_connected_to_tx_coreclock_), //  output,    width = 1, tx_coreclock.export
		.tx_inclock   (_connected_to_tx_inclock_),   //   input,    width = 1,      inclock.export
		.pll_areset   (_connected_to_pll_areset_),   //   input,    width = 1,   pll_areset.export
		.tx_locked    (_connected_to_tx_locked_)     //  output,    width = 1,   pll_locked.export
	);

