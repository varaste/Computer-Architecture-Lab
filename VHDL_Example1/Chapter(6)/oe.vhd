library IEEE;
use IEEE.std_logic_1164.all;

use work.primitive.all;

entity tribuffer is port (
  input: in std_logic;
  enable: in std_logic;
  output: out std_logic
  );
end tribuffer;

architecture structural of tribuffer is

begin

  u1: tribuf port map (ip => input,
                       oe => enable,
                       op => output
                      );

end structural;
