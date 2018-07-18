library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdder is
    Port ( ai : in  STD_LOGIC;
           bi : in  STD_LOGIC;
           ci : in  STD_LOGIC;
           s : out  STD_LOGIC;
           co : out  STD_LOGIC);
end fullAdder;

architecture Behavioral of fullAdder is

component halfAdder is
Port(
ai,bi: in std_logic;
s,c : out std_logic
);
End component halfAdder;

signal s1,s2,s3 :std_logic;
begin

half1 : halfAdder port map ( ai => ai,bi => bi,s => s1,c => s2);
half2 : halfAdder port map ( ai => s1,bi => ci,s => s,c => s3);
co <= s2 or s3;


end Behavioral;