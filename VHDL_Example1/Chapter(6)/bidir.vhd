library IEEE;
use IEEE.std_logic_1164.all;

use work.primitive.all;

entity bidirbuffer is port (
  input: in std_logic;
  enable: in std_logic;
  feedback: out std_logic;
  output: inout std_logic
  );
end bidirbuffer;

architecture structural of bidirbuffer is

begin

  u1: bidir port map (ip => input,
                      oe => enable,
                      op_fb => feedback,
                      op => output
                      );

end structural;
