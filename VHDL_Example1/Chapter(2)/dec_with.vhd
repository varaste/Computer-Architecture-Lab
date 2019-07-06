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
  with dev_adr(19 downto 17) select
    sio_dec_n <= '0' when SuperIORange,
                 '1' when others;

  with dev_adr(19 downto 0) select
    int_ctrl_rd_n <= '0' when CtrlRegRange & IntCtrlReg,
                     '1' when others;

  with dev_adr(19 downto 0) select
    io_int_stat_rd_n <= '0' when CtrlRegRange & IoIntStatReg,
                        '1' when others;

  with dev_adr(19 downto 0) select
    rst_ctrl_rd_n <= '0' when CtrlRegRange & RstCtrlReg,
                     '1' when others;

  with dev_adr(19 downto 0) select
    atc_stat_rd_n <= '0' when CtrlRegRange & AtcStatusReg,
                     '1' when others;

  with dev_adr(19 downto 0) select
    mgmt_stat_rd_n <= '0' when CtrlRegRange & MgmtStatusReg,
                      '1' when others;


end synthesis;
