library IEEE;
use IEEE.std_logic_1164.all;

entity BIDIR is port (
  ip: in std_logic;
  oe: in std_logic;
  op_fb: out std_logic;
  op: inout std_logic
  );
end BIDIR;

architecture rtl of BIDIR is

begin

  op <= ip when oe = '1' else 'Z';
  op_fb <= op;

end rtl;

