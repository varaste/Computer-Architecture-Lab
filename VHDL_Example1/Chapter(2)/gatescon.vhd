library IEEE;
use IEEE.std_logic_1164.all;


entity FEWGATES is port (
  a,b,c,d: in std_logic;
  y: out std_logic
  );
end FEWGATES;

architecture concurrent of FEWGATES is

signal a_and_b, c_and_d, not_c_and_d: std_logic;

begin

  a_and_b <= '1' when a = '1' and b = '1' else '0';
  c_and_d <= '1' when c = '1' and d = '1' else '0';

  not_c_and_d <= not c_and_d;

  y <= '1' when a_and_b = '1' or not_c_and_d = '1' else '0';

end concurrent;
