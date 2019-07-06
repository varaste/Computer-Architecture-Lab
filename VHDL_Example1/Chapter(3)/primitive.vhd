library IEEE;
use IEEE.std_logic_1164.all;

package primitive is
  component DFFE port (
    d: in std_logic;
    q: out std_logic;
    en: in std_logic;
    clk: in std_logic
    );
  end component;

  component DLATCHH port (
    d: in std_logic;
    en: in std_logic;
    q: out std_logic
    );
  end component;
end package;

library IEEE;
use IEEE.std_logic_1164.all;

entity DFFE is port (
    d: in std_logic;
    q: out std_logic;
    en: in std_logic;
    clk: in std_logic
    );
end DFFE;

architecture rtl of DFFE is

begin

  process begin
    wait until clk = '1';
      if (en = '1') then
        q <= d;
      end if;
  end process;

end rtl;

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

  process (en) begin
    if (en = '1') then
      q <= d;
    end if;
  end process;

end rtl;
