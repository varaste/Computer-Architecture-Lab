library IEEE;
use IEEE.std_logic_1164.all;

entity DLATCHH is port (
    d: in std_logic;
    en: in std_logic;
    q: out std_logic
    );
end DLATCHH;

architecture rtl of DLATCHH is

begin

  process (en, d) begin
    if en = '1' then
      q <= d;
    end if;
  end process;

end rtl;
