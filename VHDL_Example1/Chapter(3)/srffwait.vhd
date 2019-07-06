library IEEE;
use IEEE.std_logic_1164.all;

entity SRFF is port (
    s,r: in std_logic;
    clk: in std_logic;
    q: out std_logic
    );
end SRFF;

architecture rtl of SRFF is

begin

  process begin
    wait until clk = '1';
      if s = '0' and r = '1' then
	q <= '0';
      elsif s = '1' and r = '0' then
	q <= '1';
      end if;
  end process;

end rtl;
