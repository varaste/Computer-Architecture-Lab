
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
    if (prst = '1') then
      q <= '1';
    elsif (rst = '1') then
      q <= '0';
    elsif (clk'event and clk = '1') then
      if (en = '1') then
        q <= d;
      end if;
    end if;
  end process;

end rtl;


