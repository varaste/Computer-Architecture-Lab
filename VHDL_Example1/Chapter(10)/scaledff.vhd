library IEEE;
use IEEE.std_logic_1164.all;

use work.primitive.all;

entity scaleDFF is port (
  data: in std_logic_vector(7 downto 0);
  clock: in std_logic;
  enable: in std_logic;
  qout: out std_logic_vector(7 downto 0)
  );
end scaleDFF;

architecture scalable of scaleDFF is

begin

  u1: sDFFE port map (d => data,
                      clk =>clock,
                      en => enable,
                      q => qout
                     );

end scalable;
