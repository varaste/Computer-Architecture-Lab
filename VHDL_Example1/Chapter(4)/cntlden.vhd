-- Incorporates Errata 5.4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is port (
  clk: in std_logic;
  reset: in std_logic;
  load: in std_logic;
  enable: in std_logic;
  data: in std_logic_vector(3 downto 0);
  count: out std_logic_vector(3 downto 0)
  );
end counter;

architecture simple of counter is

signal countL: unsigned(3 downto 0);

begin

  increment: process (clk, reset) begin
    if (reset = '1') then
      countL <= "0000";
    elsif(clk'event and clk = '1') then
      if (load = '1') then
        countL <= to_unsigned(data);
      elsif (enable = '1') then
        countL <= countL + 1;
      end if;
    end if;
  end process;
  
  count <= std_logic_vector(countL);

end simple;
