library IEEE;
use IEEE.std_logic_1164.all;

entity clkGen is port (
  clk: in std_logic;
  reset: in std_logic;
  ClkDiv2, ClkDiv4,
  ClkDiv6,ClkDiv8: out std_logic
  );
end clkGen;
 
architecture behav of clkGen is

subtype numClks is std_logic_vector(1 to 4);
subtype numPatterns is integer range 0 to 11;

type clkTableType is array (numpatterns'low to numPatterns'high) of numClks;

constant clkTable: clkTableType := clkTableType'(
-- ClkDiv8______
-- ClkDiv6_____ |
-- ClkDiv4____ ||
-- ClkDiv2 __ |||
--           ||||
            "1111",
            "0111",
            "1011",
            "0001",
            "1100",
            "0100",
            "1010",
            "0010",
            "1111",
            "0001",
            "1001",
            "0101"); 

signal index: numPatterns;
 
begin

  lookupTable: process (clk, reset) begin
    if reset = '1' then
      index <= 0;
    elsif (clk'event and clk = '1') then
      if index = numPatterns'high then
        index <= numPatterns'low;
      else
        index <= index + 1;
      end if;
    end if;
  end process;

  (ClkDiv2,ClkDiv4,ClkDiv6,ClkDiv8) <= clkTable(index);

end behav;
