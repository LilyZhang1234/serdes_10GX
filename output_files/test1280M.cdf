/* Quartus Prime Version 20.4.0 Build 72 12/14/2020 SC Pro Edition */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(10M08SA) MfrSpec(OpMask(0) SEC_Device(CFI_2GB) Child_OpMask(1 0));
	P ActionCode(Cfg)
		Device PartName(10CX220YF780) Path("C:/Lily_Zhang/GBS20V1/FPGA/Cyclone10/10GX1280M_test-master/10GX1280M_test-master_bk20210609/output_files/") File("test1280M.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
