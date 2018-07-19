
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity zarbkonanade is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           p : out  STD_LOGIC_VECTOR (7 downto 0));
end zarbkonanade;

architecture Behavioral of zarbkonanade is

component Ripple is
Port(
a,b: in STD_LOGIC_VECTOR (3 downto 0);
c0 : in std_logic;
s : out STD_LOGIC_VECTOR (3 downto 0);
c4 : out std_logic
);
End component Ripple;
signal temp : STD_LOGIC_VECTOR (15 downto 0);
signal ftemp : STD_LOGIC_VECTOR (3 downto 0);
signal stemp : STD_LOGIC_VECTOR (3 downto 0);
begin

temp(0) <= b(0) and a(0);
temp(1) <= b(0) and a(1);
temp(2) <= b(0) and a(2);
temp(3) <= b(0) and a(3);
temp(4) <= b(1) and a(0);
temp(5) <= b(1) and a(1);
temp(6) <= b(1) and a(2);
temp(7) <= b(1) and a(3);
temp(8) <= b(2) and a(0);
temp(9) <= b(2) and a(1);
temp(10) <= b(2) and a(2);
temp(11) <= b(2) and a(3);
temp(12) <= b(3) and a(0);
temp(13) <= b(3) and a(1);
temp(14) <= b(3) and a(2);
temp(15) <= b(3) and a(3);

p(0) <= temp(0);
Ripple1 : Ripple port map (a(0) => temp(1),a(1) => temp(2),a(2) => temp(3),a(3) => '0',b(0) => temp(4),b(1) => temp(5),b(2) => temp(6),b(3) => temp(7),c0 => '0',s(0) => p(1),s(1) => stemp(0),s(2) => stemp(1),s(3) => stemp(2),c4 => stemp(3));
Ripple2 : Ripple port map (a(0) => stemp(0),a(1) => stemp(1),a(2) => stemp(2),a(3) => stemp(3),b(0) => temp(8),b(1) => temp(9),b(2) => temp(10),b(3) => temp(11),c0 => '0',s(0) => p(2),s(1) => ftemp(0),s(2) => ftemp(1),s(3) => ftemp(2),c4 => ftemp(3));
Ripple3 : Ripple port map (a(0) => ftemp(0),a(1) => ftemp(1),a(2) => ftemp(2),a(3) => ftemp(3),b(0) => temp(12),b(1) => temp(12),b(2) => temp(14),b(3) => temp(15),c0 => '0',s(0) => p(3),s(1) => p(4),s(2) => p(5),s(3) => p(6),c4 => p(7));
end Behavioral;

