-- incorporates Errata 12.1

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity typeConvert is port (
  a: out unsigned(7 downto 0)
  );
end typeConvert;

architecture simple of typeConvert is

constant Const: natural := 43;

begin

  a <= To_unsigned(Const,8);

end simple;
