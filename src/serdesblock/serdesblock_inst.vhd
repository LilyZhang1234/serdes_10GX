	component serdesblock is
		port (
			tx_in        : in  std_logic_vector(127 downto 0) := (others => 'X'); -- export
			tx_out       : out std_logic_vector(15 downto 0);                     -- export
			tx_coreclock : out std_logic;                                         -- export
			tx_inclock   : in  std_logic                      := 'X';             -- export
			pll_areset   : in  std_logic                      := 'X';             -- export
			tx_locked    : out std_logic                                          -- export
		);
	end component serdesblock;

	u0 : component serdesblock
		port map (
			tx_in        => CONNECTED_TO_tx_in,        --        tx_in.export
			tx_out       => CONNECTED_TO_tx_out,       --       tx_out.export
			tx_coreclock => CONNECTED_TO_tx_coreclock, -- tx_coreclock.export
			tx_inclock   => CONNECTED_TO_tx_inclock,   --      inclock.export
			pll_areset   => CONNECTED_TO_pll_areset,   --   pll_areset.export
			tx_locked    => CONNECTED_TO_tx_locked     --   pll_locked.export
		);

