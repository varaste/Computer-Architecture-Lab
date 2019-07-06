library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is port (
    d: in std_logic;
    clk: in std_logic;
    a,b,c : in std_logic;
    q: out std_logic
    );
end DFF;

architecture rtl of DFF is

signal localRst: std_logic;

begin

  localRst <= '1' when (( a = '1' and b = '1') or c = '1') else '0';

  process (clk, localRst) begin
    if localRst = '1' then
      q <= '0';
    elsif clk'event and clk = '1' then
        q <= d;
    end if;
  end process;

end rtl;
