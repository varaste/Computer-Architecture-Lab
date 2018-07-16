
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity moore is
    Port ( clk : in  STD_LOGIC;
           input : in  STD_LOGIC;
           output : out  STD_LOGIC;
			  output_string : out  STD_LOGIC_VECTOR (4 downto 0));
end moore;

architecture Behavioral of moore is
type state_t is(s0,s1,s2,s3,s4);
signal state : state_t :=s0;
signal next_state :state_t:=s0;

begin

	output_string <= "00000";
	CMB:process(state,input)
	begin
		case state is
			when s0=>
				if (input = '1')then
					next_state <=s1;
					output_string <= "00001";
				else
					next_state <= s0;
					output_string <= "00000";
				end if;
				
			when s1=>
				if (input = '1')then
					next_state <=s2;
					output_string <= "00010";
				else
					next_state <= s0;
					output_string <= "00000";
				end if;
				
			when s2=>
				if (input = '1')then
					next_state <=s2;
					output_string <= "00010";
				else
					next_state <= s3;
					output_string <= "00011";
				end if;
				
			when s3=>
				if (input = '1')then
					next_state <=s4;
					output_string <= "00100";
				else
					next_state <= s0;
					output_string <= "00000";
				end if;
				
			when s4=>
				if (input = '1')then
					next_state <=s2;
					output_string <= "00010";
				else
					next_state <= s0;
					output_string <= "00000";
				end if;
		end case;
	end process;
	REG : process(clk)
		begin
			if(clk'event and clk = '1')then
				state <= next_state;
			end if;
		end process;
output <= '0' when state = s0 else
			 '0' when state = s1 else
			 '0' when state = s2 else
			 '0' when state = s3 else
			 '1' when state = s4 ;

end Behavioral;

