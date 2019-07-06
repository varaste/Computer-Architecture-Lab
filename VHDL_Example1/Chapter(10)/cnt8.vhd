library IEEE;
use IEEE.std_logic_1164.all;

use work.scaleable.all;

entity count8 is port (
  clk: in std_logic;
  rst: in std_logic;
  count: out std_logic_vector(7 downto 0)
  );
end count8;

architecture structural of count8 is

begin

  u1: scaleUpCnt port map (clk => clk,
                           reset => rst,
                           cnt => count
                          );

end structural;
