library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity asyncLdCnt is port (
  loadVal: in std_logic_vector(3 downto 0);
  clk, load: in std_logic;
  q: out std_logic_vector(3 downto 0)
  );
end asyncLdCnt;

architecture rtl of asyncLdCnt is

signal qLocal: unsigned(3 downto 0);

begin

  process (clk, load, loadVal) begin
    if (load = '1') then
      qLocal <= to_unsigned(loadVal);
    elsif (clk'event and clk = '1' ) then
      qLocal <= qLocal + 1;
    end if;
  end process;

  q <= to_stdlogicvector(qLocal);

end rtl;
