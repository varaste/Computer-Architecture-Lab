library IEEE;
use IEEE.std_logic_1164.all;

entity DFFE is port (
    d: in std_logic;
    en: in std_logic;
    clk: in std_logic;
    q: out std_logic
    );
end DFFE;

architecture rtl of DFFE is

begin

  process begin
    wait until clk = '1';
      if en = '1' then
        q <= d;
      end if;
  end process;

end rtl;
