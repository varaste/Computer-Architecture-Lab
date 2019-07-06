library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity convertArith is port (
  truncate: out unsigned(3 downto 0);
  extend: out unsigned(15 downto 0);
  direction: out unsigned(0 to 7)
  );
end convertArith;

architecture simple of convertArith is

constant Const: unsigned(7 downto 0) := "00111010";

begin

  truncate  <= resize(Const, truncate'length);
  extend    <= resize(Const, extend'length);
  direction <= resize(Const, direction'length);

end simple;
