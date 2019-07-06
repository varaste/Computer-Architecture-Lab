library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is port (
    d: in std_logic;
    clk: in std_logic;
    q: out std_logic
    );
end DFF;

architecture rtl of DFF is

begin

  process (clk) begin
    wait until clk = '1';
      q <= d;
  end process;

end rtl;
