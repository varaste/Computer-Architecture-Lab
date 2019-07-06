library IEEE;
use IEEE.std_logic_1164.all;

entity TRIBUF is port (
  ip: in std_logic;
  oe: in std_logic;
  op: out std_logic
  );
end TRIBUF;

architecture concurrent of TRIBUF is

begin

  op <= ip when oe = '1' else 'Z';

end concurrent;
