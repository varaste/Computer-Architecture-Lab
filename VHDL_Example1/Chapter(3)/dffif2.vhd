library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is port (
    d: in std_logic;
    clk: in std_logic;
    envector: in std_logic_vector(7 downto 0);
    q: out std_logic
    );
end DFF;

architecture rtl of DFF is

begin

  process (clk) begin
    if clk'event and clk = '1' then
      if envector = "10010111" then
        q <= d;
      end if;
    end if;
  end process;

end rtl;
