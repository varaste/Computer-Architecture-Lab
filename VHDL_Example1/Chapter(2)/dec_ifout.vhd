library ieee;
use ieee.std_logic_1164.all;

entity isa_dec is port
(
  dev_adr:          in std_logic_vector(19 downto 0);
  cs0_n:            in std_logic;

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

  signal Lsio_dec_n:        std_logic;
  signal Lrst_ctrl_rd_n:    std_logic;
  signal Latc_stat_rd_n:    std_logic;
  signal Lmgmt_stat_rd_n:   std_logic;
  signal Lio_int_stat_rd_n: std_logic;
  signal Lint_ctrl_rd_n:    std_logic;

begin

  decoder: process (dev_adr)
    begin 
      -- Set defaults for outputs - for synthesis reasons.

        Lsio_dec_n        <= '1';
        Lint_ctrl_rd_n    <= '1';
        Lio_int_stat_rd_n <= '1';
        Lrst_ctrl_rd_n    <= '1';
        Latc_stat_rd_n    <= '1';
        Lmgmt_stat_rd_n   <= '1';

        case dev_adr(19 downto 17) is 

        when SuperIoRange =>
          Lsio_dec_n <= '0';
		
        when CtrlRegRange =>

          case dev_adr(16 downto 0) is
			
            when IntCtrlReg =>
              Lint_ctrl_rd_n <= '0';

            when IoIntStatReg =>
              Lio_int_stat_rd_n <= '0';

            when RstCtrlReg =>
              Lrst_ctrl_rd_n <= '0';

            when AtcStatusReg =>
              Latc_stat_rd_n <= '0';

            when MgmtStatusReg =>
              Lmgmt_stat_rd_n <= '0';

            when others =>
              null;
							
            end case;

          when others =>
            null;                     
                         
        end case;

  end process decoder;

  qualify: process (cs0_n) begin

    sio_dec_n        <= '1';
    int_ctrl_rd_n    <= '1';
    io_int_stat_rd_n <= '1';
    rst_ctrl_rd_n    <= '1';
    atc_stat_rd_n    <= '1';
    mgmt_stat_rd_n   <= '1';

    if (cs0_n = '0') then
      sio_dec_n        <= Lsio_dec_n;
      int_ctrl_rd_n    <= Lint_ctrl_rd_n;
      io_int_stat_rd_n <= Lio_int_stat_rd_n;
      rst_ctrl_rd_n    <= Lrst_ctrl_rd_n;
      atc_stat_rd_n    <= Latc_stat_rd_n;
      mgmt_stat_rd_n   <= Lmgmt_stat_rd_n;
    else
      null;
    end if;
  end process qualify;

end synthesis;
