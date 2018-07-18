
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Ripple is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           c0 : in  STD_LOGIC;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
           c4 : out  STD_LOGIC);
end Ripple;

architecture Behavioral of Ripple is

component fullAdder is
Port(
ai,bi,ci: in std_logic;
s,co : out std_logic
);
End component fullAdder;
signal c1,c2,c3:std_logic;
begin
full1 : fullAdder port map ( ai => a(0),bi => b(0) ,ci => c0,s => s(0),co => c1);
full2 : fullAdder port map ( ai => a(1),bi => b(1) ,ci => c1,s => s(1),co => c2);
full3 : fullAdder port map ( ai => a(2),bi => b(2) ,ci => c2,s => s(2),co => c3);
full14 : fullAdder port map ( ai => a(3),bi => b(3) ,ci => c3,s => s(3),co => c4);

end Behavioral;

