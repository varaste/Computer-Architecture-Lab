library IEEE;
use IEEE.std_logic_1164.all;

entity asyncLoad is port (
  loadVal, d: in std_logic_vector(3 downto 0);
  clk, load: in std_logic;
  q: out std_logic_vector(3 downto 0)
  );
end asyncLoad;

architecture rtl of asyncLoad is

begin

  process (clk, load, loadVal) begin
    if (load = '1') then
      q <= loadVal;
    elsif (clk'event and clk = '1' ) then
      q <= d;
    end if;
  end process;

end rtl;
