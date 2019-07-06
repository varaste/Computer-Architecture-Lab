library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is port (
  a,b: in std_logic_vector(3 downto 0);
  sum: out std_logic_vector(3 downto 0);
  overflow: out std_logic
  );
end adder;

architecture concat of adder is

signal localSum: std_logic_vector(4 downto 0);

begin

  localSum <= std_logic_vector(unsigned('0' & a) + unsigned('0' & b));

  sum <= localSum(3 downto 0);
  overflow <= localSum(4);

end concat;
