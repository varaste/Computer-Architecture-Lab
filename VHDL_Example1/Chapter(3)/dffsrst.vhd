library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is port (
    d: in std_logic;
    clk: in std_logic;
    srst : in std_logic;
    q: out std_logic
    );
end DFF;

architecture rtl of DFF is

begin

  process (clk) begin
    if clk'event and clk = '1' then
      if srst = '1' then
	q <= '0';
      else
        q <= d;
      end if;
    end if;
  end process;

end rtl;
