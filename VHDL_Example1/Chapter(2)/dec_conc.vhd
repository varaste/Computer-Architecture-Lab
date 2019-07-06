library ieee;
use ieee.std_logic_1164.all;

entity isa_dec is port
(
  dev_adr:         in std_logic_vector(19 downto 0);

  sio_dec_n:       out std_logic;
  rst_ctrl_rd_n:   out std_logic;
  atc_stat_rd_n:   out std_logic;
  mgmt_stat_rd_n:  out std_logic;
  io_int_stat_rd_n:out std_logic;
  int_ctrl_rd_n:   out std_logic
  );
end isa_dec;


architecture synthesis of isa_dec is

  constant  CtrlRegRange: std_logic_vector(2 downto 0)  := "100";
  constant  SuperIoRange: std_logic_vector(2 downto 0)  := "010";

  constant  IntCtrlReg:   std_logic_vector(16 downto 0) := "00000000000000000";
  constant  IoIntStatReg: std_logic_vector(16 downto 0) := "00000000000000001";
  constant  RstCtrlReg:   std_logic_vector(16 downto 0) := "00000000000000010";
  constant  AtcStatusReg: std_logic_vector(16 downto 0) := "00000000000000011";
  constant  MgmtStatusReg:std_logic_vector(16 downto 0) := "00000000000000100";

begin
  sio_dec_n <= '0' when dev_adr (19 downto 17) = SuperIORange else '1';

  int_ctrl_rd_n <= '0' when (dev_adr (19 downto 17) = CtrlRegRange)
                        and (dev_adr(16 downto 0) = IntCtrlReg) else '1';

  io_int_stat_rd_n <= '0' when (dev_adr (19 downto 17) = CtrlRegRange)
                           and (dev_adr(16 downto 0) = IoIntStatReg) else '1';

  rst_ctrl_rd_n <= '0' when (dev_adr (19 downto 17) = CtrlRegRange)
                        and (dev_adr(16 downto 0) = RstCtrlReg) else '1';

  atc_stat_rd_n <= '0' when (dev_adr (19 downto 17) = CtrlRegRange)
                        and (dev_adr(16 downto 0) = AtcStatusReg) else '1';

  mgmt_stat_rd_n <= '0' when (dev_adr (19 downto 17) = CtrlRegRange)
                         and (dev_adr(16 downto 0) = MgmtStatusReg) else '1';


end synthesis;
