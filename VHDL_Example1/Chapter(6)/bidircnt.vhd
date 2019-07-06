library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity BidirCnt is port (
  OE: in std_logic;
  CntEnable: in std_logic;
  LdCnt: in std_logic;
  Clk: in std_logic;
  Rst: in std_logic;
  Cnt: inout std_logic_vector(3 downto 0)
  );
end BidirCnt;

architecture behavioral of BidirCnt is

signal CntVal: std_logic_vector(3 downto 0);

begin

  counter: process (Clk, Rst) begin
    if Rst = '1' then
      CntVal <= (others => '0');
    elsif (Clk'event and Clk = '1') then
      if (LdCnt = '1') then
        CntVal <= Cnt;
      elsif (CntEnable = '1') then
        CntVal <= CntVal + 1;
      else
        CntVal <= CntVal;
      end if;
    end if;
  end process;

  bidirBuf: process (oe,CntVal) begin
    if (oe = '1') then
      Cnt <= CntVal;
    else
      Cnt <= (others => 'Z');
    end if;
  end process;

end behavioral;
