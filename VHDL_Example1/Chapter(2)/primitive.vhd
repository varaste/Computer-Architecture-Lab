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

  component AND2 port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
  end component;

  component OR2 port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
  end component;

  component INVERTER port (
    a: in std_logic;
    y: out std_logic
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


library IEEE;
use IEEE.std_logic_1164.all;

entity AND2 is port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
end AND2;

architecture rtl of AND2 is

begin

  y <= '1' when i1 = '1' and i2 = '1' else '0';

end rtl;


library IEEE;
use IEEE.std_logic_1164.all;

entity OR2 is port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
end OR2;

architecture rtl of OR2 is

begin

  y <= '1' when i1 = '1' or i2 = '1' else '0';

end rtl;



library IEEE;
use IEEE.std_logic_1164.all;

entity INVERTER is port (
    a: in std_logic;
    y: out std_logic
    );
end INVERTER;

architecture rtl of INVERTER is

begin

  y <= not a;

end rtl;
