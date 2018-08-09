
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxTwo is
    Port ( a0 : in  STD_LOGIC;
           a1 : in  STD_LOGIC;
           b : in  STD_LOGIC;
           f : out  STD_LOGIC);
end muxTwo;

architecture Behavioral of muxTwo is
signal bnot,c0,c1:std_logic;

begin

bnot <= not(b);

c0 <= bnot and a0;
c1 <= b and a1;
f <= c0 or c1;


end Behavioral;

