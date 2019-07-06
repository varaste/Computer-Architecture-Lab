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

  component DFFE_SR port (
    d: in std_logic;
    en: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    prst: in std_logic;
    q: out std_logic
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
    i: in std_logic;
    o: out std_logic
    );
  end component;

  component TRIBUF port (
    ip: in std_logic;
    oe: in std_logic;
    op: out std_logic
    );
  end component;

  component BIDIR port (
    ip: in std_logic;
    oe: in std_logic;
    op_fb: out std_logic;
    op: inout std_logic
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

entity DFFE_SR is port (
    d: in std_logic;
    en: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    prst: in std_logic;
    q: out std_logic
    );
end DFFE_SR;

architecture rtl of DFFE_SR is

begin

  process (clk, rst, prst) begin
    if (rst = '1') then
      q <= '0';
    elsif (prst = '1') then
      q <= '1';
    elsif (clk'event and clk = '1') then
      if (en = '1') then
        q <= d;
      end if;
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
    i: in std_logic;
    o: out std_logic
    );
end INVERTER;

architecture rtl of INVERTER is

begin

  o <= not i;

end rtl;


library IEEE;
use IEEE.std_logic_1164.all;

entity TRIBUF is port (
  ip: in std_logic;
  oe: in std_logic;
  op: out std_logic
  );
end TRIBUF;

architecture rtl of TRIBUF is

begin

  op <= ip when oe = '1' else 'Z';

end rtl;


library IEEE;
use IEEE.std_logic_1164.all;

entity BIDIR is port (
  ip: in std_logic;
  oe: in std_logic;
  op_fb: out std_logic;
  op: inout std_logic
  );
end BIDIR;

architecture rtl of BIDIR is

begin

  op <= ip when oe = '1' else 'Z';
  op_fb <= op;

end rtl;

