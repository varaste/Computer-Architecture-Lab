library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is port (
    d1, d2: in std_logic;
    clk: in std_logic;
    arst : in std_logic;
    q1, q2: out std_logic
    );
end DFF;

architecture rtl of DFF is

begin

  process (clk, arst) begin
    if arst = '1' then
      q1 <= '0';
      q2 <= '1';
    elsif clk'event and clk = '1' then
      q1 <= d1;
      q2 <= d2;
    end if;
  end process;

end rtl;
