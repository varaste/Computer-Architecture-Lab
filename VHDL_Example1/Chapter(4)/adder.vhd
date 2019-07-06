library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is port (
  a,b: in unsigned(3 downto 0);
  sum: out unsigned(3 downto 0)
  );
end adder;

architecture simple of adder is

begin

  sum <= a + b;

end simple;
