
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mealy is
    Port ( input : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           output : out  STD_LOGIC;
           output_string :out STD_LOGIC_VECTOR (4 downto 0));
end mealy;

architecture Behavioral of mealy is
type state_t is(s0,s1,s2,s3,s4);
signal state : state_t :=s0;
signal next_state :state_t:=s0;
begin

CMB:process(state,input)
	begin
		case state is
			when s0=>
				if (input = '1')then
					next_state <=s1;
					output_string <= "00001";
					output <= '0';
					
				else
					next_state <= state;
					output_string <= "00000";
					output <= '0';
				end if;
				
			when s1=>
				if (input = '1')then
					next_state <=s2;
					output_string <= "00010";
					output <= '0';
				else
					next_state <= s0;
					output_string <= "00000";
					output <= '0';
				end if;
				
			when s2=>
				if (input = '1')then
					next_state <=s2;
					output_string <= "00010";
					output <= '0';
				else
					next_state <= s3;
					output_string <= "00011";
					output <= '0';
				end if;
				
			when s3=>
				if (input = '1')then
					next_state <=s4;
					output_string <= "00100";
					output <= '1';
				else
					next_state <= s0;
					output_string <= "00000";
					output <= '0';
				end if;
				
			when s4=>
				if (input = '1')then
					next_state <=s2;
					output_string <= "00010";
					output <= '0';
				else
					next_state <= s0;
					output_string <= "00000";
					output <= '0';
				end if;
		end case;
	end process;
	REG : process(clk)
		begin
			if rising_edge(clk) then
			state <= next_state;
			end if;
		end process;
end Behavioral;

