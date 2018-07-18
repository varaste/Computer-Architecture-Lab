
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity carryAdder is
    Port ( ai : in  STD_LOGIC_VECTOR (3 downto 0);
           bi : in  STD_LOGIC_VECTOR (3 downto 0);
           c0 : in  STD_LOGIC;
           c4 : out  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0));
end carryAdder;

architecture Behavioral of carryAdder is
component fullAdder is
Port(
ai,bi,ci: in std_logic;
s,co : out std_logic
);
End component fullAdder;
signal p,g:STD_LOGIC_VECTOR (3 downto 0);
signal c,c1,c2,c3:std_logic;
begin

full1 : fullAdder port map ( ai => ai(0),bi => bi(0) ,ci => c0,s => s(0),co => c);
g(0) <= ai(0) and bi(0);
p(0) <= ai(0) xor bi(0);
c1 <= g(0) or (c0 and p(0));


full2 : fullAdder port map ( ai => ai(1),bi => bi(1) ,ci => c1,s => s(1),co => c);
g(1) <= ai(1) and bi(1);
p(1) <= ai(1) xor bi(1);
c2 <= g(1) or (c1 and p(1));


full3 : fullAdder port map ( ai => ai(2),bi => bi(2) ,ci => c2,s => s(2),co => c);
g(2) <= ai(2) and bi(2);
p(2) <= ai(2) xor bi(2);
c3 <= g(2) or (c2 and p(2));


full4 : fullAdder port map ( ai => ai(3),bi => bi(3) ,ci => c3,s => s(3),co => c);
g(3) <= ai(3) and bi(3);
p(3) <= ai(3) xor bi(3);
c4 <= g(3) or (c3 and p(3));


end Behavioral;

