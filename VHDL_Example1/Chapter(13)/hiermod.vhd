library IEEE;
use IEEE.std_logic_1164.all;

use work.simPrimitives.all;

entity simHierarchy is port (
  A, B, Clk: in std_logic;
  Y: out std_logic
  );
end simHierarchy;

architecture hierarchical of simHierarchy is

signal ADly, BDly, OrGateDly, ClkDly: std_logic;
signal OrGate, FlopOut: std_logic;

begin

  ADly <= transport A after 2 ns;
  BDly <= transport B after 2 ns;
  OrGateDly <= transport OrGate after 1.5 ns;
  ClkDly <= transport Clk after 1 ns;

  u1: OR2 generic map (tPD => 10 ns)
          port map ( I1 => ADly,
                     I2 => BDly,
                     Y => OrGate
                   );

  u2: simDFF generic map ( tS => 4 ns,
                           tH => 3 ns,
                           tCQ => 8 ns
                         )
             port map ( D => OrGateDly,
                        Clk => ClkDly,
                        Q => FlopOut
                      );

  Y <= transport FlopOut after 2 ns;

end hierarchical;
