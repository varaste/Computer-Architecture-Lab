library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FEWGATES is port (
  a,b,c,d: in std_logic;
  y: out std_logic
  );
end FEWGATES;

architecture concurrent of FEWGATES is

constant THREE: std_logic_vector(1 downto 0) := "11";

begin

  y <= '1' when (a & b = THREE) or (c & d /= THREE) else '0';

end concurrent;
