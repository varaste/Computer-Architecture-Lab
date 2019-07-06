library IEEE;
use IEEE.std_logic_1164.all;
use work.primitive.all;

entity LogicFcn is port (
  A: in std_logic;
  B: in std_logic;
  C: in std_logic;
  Y: out std_logic
  );
end LogicFcn;

architecture structural of LogicFcn is

signal notA, notB, andSignal: std_logic;

begin

  i1: inverter port map (i => A,
                         o => notA);

  i2: inverter port map (i => B,
                         o => notB);

  a1: and2 port map (i1 => notA,
                     i2 => notB,
                     y => andSignal);

  o1: or2 port map (i1 => andSignal,
                    i2 => C,
                    y => Y);

end structural;
