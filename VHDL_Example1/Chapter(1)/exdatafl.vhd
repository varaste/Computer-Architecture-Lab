library IEEE;
use IEEE.std_logic_1164.all;

entity LogicFcn is port (
  A: in std_logic;
  B: in std_logic;
  C: in std_logic;
  Y: out std_logic
  );
end LogicFcn;

architecture dataflow of LogicFcn is

begin

  Y <= '1' when (A = '0' AND B = '0') OR
                (C = '1')
           else '0';

end dataflow;
