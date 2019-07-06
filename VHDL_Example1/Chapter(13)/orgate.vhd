library IEEE;
USE IEEE.std_logic_1164.all;


entity OR2 is port (
  I1, I2: in std_logic;
  Y: out std_logic
  );
end OR2;

architecture simple of OR2 is

begin

  Y <= I1 OR I2 after 10 ns;

end simple;
