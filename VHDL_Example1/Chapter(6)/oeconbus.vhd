library IEEE;
use IEEE.std_logic_1164.all;

entity TRIBUF8 is port (
  ip: in std_logic_vector(7 downto 0);
  oe: in std_logic;
  op: out std_logic_vector(7 downto 0)
  );
end TRIBUF8;

architecture concurrent of TRIBUF8 is

begin

  op <= ip when oe = '1' else (others => 'Z');

end concurrent;
