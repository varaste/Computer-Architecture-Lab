-- Incorporates Errata 5.4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accumulator is port (
  a: in std_logic_vector(3 downto 0);
  clk, reset: in std_logic;
  accum: out std_logic_vector(3 downto 0)
  );
end accumulator;

architecture simple of accumulator is

signal accumL: unsigned(3 downto 0);

begin

  accumulate: process (clk, reset) begin
    if (reset = '1') then
      accumL <= "0000";
    elsif (clk'event and clk= '1') then
      accumL <= accumL + to_unsigned(a);
    end if;
  end process;

  accum <= std_logic_vector(accumL);

end simple;
