
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myregister is
    Port ( parallel_in : in  STD_LOGIC_VECTOR (3 downto 0);
           L_R : in  STD_LOGIC_VECTOR (1 downto 0);
           serial_in : in  STD_LOGIC;
           load : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reg_out : inout  STD_LOGIC_VECTOR (3 downto 0));
end myregister;

architecture asynchronous of myregister is

component muxT is
Port(
a0,a1,a2,a3,b0,b1: in std_logic;
f : out std_logic
);
End component muxT;


component muxTwo is
Port(
a0,a1,b: in std_logic;
f : out std_logic
);
End component muxTwo;


signal fout : STD_LOGIC_VECTOR (7 downto 0);

begin
   
	
		muxT1 : muxT port map (a0 => serial_in,a1 => reg_out(1),a2 => serial_in,a3 => reg_out(1),b0 =>L_R(0),b1=>L_R(1),f => fout(0));
		muxT2 : muxT port map (a0 => reg_out(0),a1 => reg_out(2),a2 => reg_out(0),a3 => reg_out(2),b0 =>L_R(0),b1=>L_R(1),f => fout(1));
		muxT3 : muxT port map (a0 => reg_out(1),a1 => reg_out(3),a2 => reg_out(1),a3 => reg_out(3),b0 =>L_R(0),b1=>L_R(1),f => fout(2));
		muxT4 : muxT port map (a0 => reg_out(2),a1 => serial_in,a2 => reg_out(2),a3 => reg_out(3),b0 =>L_R(0),b1=>L_R(1),f => fout(3));
		
		muxTwo1 : muxTwo port map(a0 => fout(0),a1 => parallel_in(0),b => load,f => fout(4));
		muxTwo2 : muxTwo port map(a0 => fout(1),a1 => parallel_in(1),b => load,f => fout(5));
		muxTwo3 : muxTwo port map(a0 => fout(2),a1 => parallel_in(2),b => load,f => fout(6));
		muxTwo4 : muxTwo port map(a0 => fout(3),a1 => parallel_in(3),b => load,f => fout(7));
		
	

	process (clk,reset)
	variable int : Integer; 
	begin
		if reset = '1' then
		reg_out <= "0000";
		int := 0;
		elsif rising_edge(clk) then
		int := int + 1;
		
		end if;
		
		if int = 2 then
		reg_out(0) <= fout(4);
		reg_out(1) <= fout(5);
		reg_out(2) <= fout(6);
		reg_out(3) <= fout(7);
		int := 0;
		
		end if;
		
		
	end process;


end architecture;

