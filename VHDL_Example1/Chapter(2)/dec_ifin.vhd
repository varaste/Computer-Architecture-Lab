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

begin

  decoder: process (dev_adr, cs0_n)
    begin 
      -- Set defaults for outputs - for synthesis reasons.

        sio_dec_n        <= '1';
        int_ctrl_rd_n    <= '1';
        io_int_stat_rd_n <= '1';
        rst_ctrl_rd_n    <= '1';
        atc_stat_rd_n    <= '1';
        mgmt_stat_rd_n   <= '1';

        if (cs0_n = '0') then
          case dev_adr(19 downto 17) is 

          when SuperIoRange =>
            sio_dec_n <= '0';
		
          when CtrlRegRange =>

            case dev_adr(16 downto 0) is
			
              when IntCtrlReg =>
                int_ctrl_rd_n <= '0';

              when IoIntStatReg =>
                io_int_stat_rd_n <= '0';

              when RstCtrlReg =>
                rst_ctrl_rd_n <= '0';

              when AtcStatusReg =>
                atc_stat_rd_n <= '0';

              when MgmtStatusReg =>
                mgmt_stat_rd_n <= '0';

              when others =>
                null;
							
              end case;

            when others =>
              null;                     
                         
          end case;
        else
          null;
        end if;

  end process decoder;

end synthesis;
