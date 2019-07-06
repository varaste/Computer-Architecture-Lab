library IEEE;
use IEEE.std_logic_1164.all;

use work.decProcs.all;

entity decoder is port (
  decIn: in std_logic_vector(1 downto 0);
  decOut: out std_logic_vector(3 downto 0)
  );
end decoder;

architecture simple of decoder is

begin

  DEC2x4(decIn,decOut);

end simple;

