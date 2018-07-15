
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity demuxfour is
    Port ( f : in  STD_LOGIC_VECTOR (3 downto 0);
           b0 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
           a0 : out  STD_LOGIC_VECTOR (3 downto 0);
           a1 : out  STD_LOGIC_VECTOR (3 downto 0);
           a2 : out  STD_LOGIC_VECTOR (3 downto 0);
           a3 : out  STD_LOGIC_VECTOR (3 downto 0));
end demuxfour;

architecture Behavioral of demuxfour is
component demuxobe is
Port(
f,b0,b1: in std_logic;
a0,a1,a2,a3 : out std_logic
);
End component demuxobe;
signal b1not,b0not : std_logic;
begin
b1not <= Not(b1);
b0not <= Not (b0);
demux1 : demuxobe port map (f => f(0),b0 =>b0,b1=>b1,a0 => a0(0),a1 => a1(0) , a2 => a2(0),a3 => a3(0));
demux2 :  demuxobe port map (f => f(1),b0 =>b0,b1=>b1,a0 => a0(1),a1 => a1(1) , a2 => a2(1),a3 => a3(1));
demux3 :  demuxobe port map (f => f(2),b0 =>b0,b1=>b1,a0 => a0(2),a1 => a1(2) , a2 => a2(2),a3 => a3(2));
demux4 :  demuxobe port map (f => f(3),b0 =>b0,b1=>b1,a0 => a0(3),a1 => a1(3) , a2 => a2(3),a3 => a3(3));

end Behavioral;

