library ieee;
use ieee.std_logic_1164.all;

entity isa_dec is port
(
  dev_adr:          in std_logic_vector(19 downto 0);

  decOut_n:         out std_logic_vector(5 downto 0)

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

  alias sio_dec_n: std_logic is        decOut_n(5);
  alias rst_ctrl_rd_n: std_logic is    decOut_n(4);
  alias atc_stat_rd_n: std_logic is    decOut_n(3);
  alias mgmt_stat_rd_n: std_logic is   decOut_n(2);
  alias io_int_stat_rd_n: std_logic is decOut_n(1);
  alias int_ctrl_rd_n: std_logic is    decOut_n(0);

  alias upper: std_logic_vector(2 downto 0) is dev_adr(19 downto 17);
  alias CtrlBits: std_logic_vector(16 downto 0) is dev_adr(16 downto 0);

begin

  decoder: process (upper, CtrlBits)
    begin 
      -- Set defaults for outputs - for synthesis reasons.

        sio_dec_n        <= '1';
        int_ctrl_rd_n    <= '1';
        io_int_stat_rd_n <= '1';
        rst_ctrl_rd_n    <= '1';
        atc_stat_rd_n    <= '1';
        mgmt_stat_rd_n   <= '1';

        case upper is 

        when SuperIoRange =>
          sio_dec_n <= '0';
		
        when CtrlRegRange =>

          case CtrlBits is
			
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

  end process decoder;

end synthesis;
