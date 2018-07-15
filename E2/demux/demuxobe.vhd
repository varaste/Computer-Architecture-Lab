
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity demuxobe is
    Port ( f : in  STD_LOGIC;
           b0 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
           a0 : out  STD_LOGIC;
           a1 : out  STD_LOGIC;
           a2 : out  STD_LOGIC;
           a3 : out  STD_LOGIC);
end demuxobe;

architecture Behavioral of demuxobe is
signal b0not,b1not:std_logic;
begin
b0not<=Not( b0);
b1not<=Not(b1);
a0 <= (f and b1not)and b0not; 
a1 <= (f and b1not)and b0; 
a2<=(f and b1)and b0not; 
a3<= (f and b1)and b0; 

end Behavioral;

