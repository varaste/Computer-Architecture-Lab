library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is port (
  clk: in std_logic;
  enable: in std_logic;
  reset: in std_logic;
  count: buffer unsigned(3 downto 0)
  );
end counter;

architecture simple of counter is

begin

  increment: process (clk, reset) begin
    if reset = '1' then
      count <= "0000";
    elsif(clk'event and clk = '1') then
      if enable = '1' then
        count <= count + 1;
      else
        count <= count;
      end if;
    end if;
  end process;

end simple;
