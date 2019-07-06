library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity loadCnt is port (
  data: in std_logic_vector (7 downto 0);
  load: in std_logic;
  clk: in std_logic;
  rst: in std_logic;
  q: out std_logic_vector (7 downto 0)
  );
end loadCnt;

architecture rtl of loadCnt is

signal cnt: std_logic_vector (7 downto 0);

begin

  counter: process (clk, rst) begin
    if (rst = '1') then
      cnt <= (others => '0');
    elsif (clk'event and clk = '1') then
      if (load = '1') then
        cnt <= data;
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;

  q <= cnt;

end rtl;
