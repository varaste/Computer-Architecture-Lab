
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity carrySelect is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           s0 : inout  STD_LOGIC_VECTOR (3 downto 0);
           s1 : inout  STD_LOGIC_VECTOR (3 downto 0);
           s2 : out  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC);
end carrySelect;

architecture Behavioral of carrySelect is
component Ripple is
Port(
a,b: in  STD_LOGIC_VECTOR (3 downto 0);
c0 : in STD_LOGIC;
s : out  STD_LOGIC_VECTOR (3 downto 0);
c4 : out  STD_LOGIC
);
End component Ripple;
component mux is
Port(
s,a0,a1 : in STD_LOGIC;
f : out  STD_LOGIC
);
End component mux;
signal c1,c2:std_logic;
begin
Ripple1 : Ripple port map ( a => a,b => b ,c0 => '0' ,s => s0,c4 => c1);
Ripple2 : Ripple port map ( a => a,b => b ,c0 => '1' ,s => s1,c4 => c2);
mux1 : mux port map ( s => cin , a0 => s0(0),a1 => s1(0),f => s2(0) );
mux2 : mux port map ( s => cin , a0 => s0(1),a1 => s1(1),f => s2(1) );
mux3 : mux port map ( s => cin , a0 => s0(2),a1 => s1(2),f => s2(2) );
mux4 : mux port map ( s => cin , a0 => s0(3),a1 => s1(3),f => s2(3) );
mux5 : mux port map ( s => cin , a0 => c1,a1 => c2,f => cout );
end Behavioral;

