library IEEE;
use IEEE.std_logic_1164.all;

use work.primitive.all;

entity FEWGATES is port (
  a,b,c,d: in std_logic;
  y: out std_logic
  );
end FEWGATES;

architecture structural of FEWGATES is

signal a_and_b, c_and_d, not_c_and_d: std_logic;

begin

  u1: and2 port map (i1 => a ,
                     i2 => b,
                     y => a_and_b
                     );

  u2: and2 port map (i1 =>c,
                     i2 => d,
                     y => c_and_d
                     );

  u3: inverter port map (a => c_and_d,
                         y => not_c_and_d);

  u4: or2 port map (i1 => a_and_b,
                    i2 => not_c_and_d,
                    y => y
                    );

end structural;
