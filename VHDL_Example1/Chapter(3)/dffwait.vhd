library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is port (
    d: in std_logic;
    clk: in std_logic;
    en: in std_logic;
    q: out std_logic
    );
end DFF;

architecture rtl of DFF is

begin

  process begin
    wait until clk = '1';
      if en = '1' then
        q <= d;
      end if;
  end process;

end rtl;
