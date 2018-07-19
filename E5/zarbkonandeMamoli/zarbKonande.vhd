
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity zarbKonande is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           p : out  STD_LOGIC_VECTOR (7 downto 0));
end zarbKonande;

architecture Behavioral of zarbKonande is

component halfAdder is
Port(
ai,bi: in std_logic;
s,c : out std_logic
);
End component halfAdder;

component fullAdder is
Port(
ai,bi,ci: in std_logic;
s,co : out std_logic
);
End component fullAdder;

signal c1,s1,c2,s2,c3,s3,c4 ,c5,s4,c6,s5,c7,s6,c8,c9,c10,c11:std_logic;
signal temp : STD_LOGIC_VECTOR (14 downto 0);
begin
temp(0) <= b(0) and a(1);
temp(1) <= b(1) and a(0);
temp(2) <= b(0) and a(2);
temp(3) <= b(1) and a(1);
temp(4) <= b(0) and a(3);
temp(5) <= b(1) and a(2);
temp(6) <= b(1) and a(3);
temp(7) <= b(2) and a(0);
temp(8) <= b(2) and a(1);
temp(9) <= b(2) and a(2);
temp(10) <= b(2) and a(3);
temp(11) <= b(3) and a(0);
temp(12) <= b(3) and a(1);
temp(13) <= b(3) and a(2);
temp(14) <= b(3) and a(3);
p(0) <= a(0) and b(0);
half1 : halfAdder port map ( ai => temp(0),bi => temp(1),s => p(1),c => c1);
full1 : fullAdder port map (ai =>temp(2) ,bi =>temp(3) , ci => c1 ,s => s1,co =>c2 );
full2 : fullAdder port map (ai =>temp(4) ,bi =>temp(5) , ci => c2 ,s => s2,co =>c3 );
half2 : halfAdder port map ( ai => c3,bi => temp(6),s => s3,c => c4);
half3 : halfAdder port map ( ai => temp(7),bi => s1,s => p(2),c => c5);
full3 : fullAdder port map (ai =>temp(8) ,bi =>s2 , ci => c5 ,s => s4,co =>c6 );
full4 : fullAdder port map (ai =>temp(9) ,bi =>s3 , ci => c6 ,s => s5,co =>c7 );
full5 : fullAdder port map (ai =>temp(10) ,bi =>c4 , ci => c7 ,s => s6,co =>c8 );
half4 : halfAdder port map ( ai => temp(11),bi => s4,s => p(3),c => c9);
full6 : fullAdder port map (ai =>temp(12) ,bi =>s5 , ci => c9 ,s => p(4),co =>c10 );
full7 : fullAdder port map (ai =>temp(13) ,bi =>s6 , ci => c10 ,s => p(5),co =>c11 );
full8 : fullAdder port map (ai =>temp(14) ,bi =>c8 , ci => c11 ,s => p(6),co =>p(7) );

end Behavioral;

