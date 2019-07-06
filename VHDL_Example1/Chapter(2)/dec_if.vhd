library ieee;
use ieee.std_logic_1164.all;

entity isa_dec is port
(
  dev_adr:          in std_logic_vector(19 downto 0);

  sio_dec_n:        out std_logic;
  rst_ctrl_rd_n:    out std_logic;
  atc_stat_rd_n:    out std_logic;
  mgmt_stat_rd_n:   out std_logic;
  io_int_stat_rd_n: out std_logic;
  int_ctrl_rd_n:    out std_logic
);
end isa_dec;


architecture synthesis of isa_dec is

  constant  CtrlRegRange: std_logic_vector(2 downto 0)    := "100";
  constant  SuperIoRange: std_logic_vector(2 downto 0)    := "010";

  constant  IntCtrlReg:   std_logic_vector(16 downto 0) := "00000000000000000";
  constant  IoIntStatReg: std_logic_vector(16 downto 0) := "00000000000000001";
  constant  RstCtrlReg:   std_logic_vector(16 downto 0) := "00000000000000010";
  constant  AtcStatusReg: std_logic_vector(16 downto 0) := "00000000000000011";
  constant  MgmtStatusReg:std_logic_vector(16 downto 0) := "00000000000000100";

begin

  decoder: process ( dev_adr)
    begin 
      -- Set defaults for outputs - for synthesis reasons.

        sio_dec_n        <= '1';
        int_ctrl_rd_n    <= '1';
        io_int_stat_rd_n <= '1';
        rst_ctrl_rd_n    <= '1';
        atc_stat_rd_n    <= '1';
        mgmt_stat_rd_n   <= '1';

        if dev_adr(19 downto 17) = SuperIOrange then

          sio_dec_n <= '0';

        elsif dev_adr(19 downto 17) = CtrlRegrange then

          if dev_adr(16 downto 0) = IntCtrlReg then

            int_ctrl_rd_n <= '0';

          elsif dev_adr(16 downto 0)= IoIntStatReg then

            io_int_stat_rd_n <= '0';

          elsif dev_adr(16 downto 0) = RstCtrlReg then

            rst_ctrl_rd_n <= '0';

          elsif dev_adr(16 downto 0) = AtcStatusReg then

            atc_stat_rd_n <= '0';

          elsif dev_adr(16 downto 0) = MgmtStatusReg then

            mgmt_stat_rd_n <= '0';

          else

            null;
							
          end if;

        else

          null;

        end if;

  end process decoder;

end synthesis;
