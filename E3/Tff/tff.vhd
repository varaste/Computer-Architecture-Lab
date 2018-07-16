
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tff is
    Port ( T : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           Q : inout  STD_LOGIC);
end entity;

architecture Behavioral of tff is

begin
	process(clk , reset)
		begin
		if reset = '1' then
		Q <= '0';
		elsif clk'event and clk = '0' then
		Q <= Q xor T;
		end if;
	end process;


end Behavioral;

