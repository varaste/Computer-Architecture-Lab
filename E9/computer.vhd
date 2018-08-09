library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all; 

entity computer is
	Port(
	clk : in std_logic;
	reset : in std_logic;
	output : out std_logic_vector(11 downto 0);
	checkstate : out std_logic_vector(3 downto 0)
	);
end computer;

architecture Behavioral of computer is

--type state_t is(s0,s1,s2,s3,s4,s5);
signal state : std_logic_vector(3 downto 0);
type memory is array (0 to 19) of std_logic_vector(15 downto 0);
signal AC : std_logic_vector(16 downto 0);--AC(16) is carry
signal DR : std_logic_vector(15 downto 0);
signal IR : std_logic_vector(15 downto 0);
signal PC : std_logic_vector(5 downto 0);
signal AR : std_logic_vector(5 downto 0);
signal TMP : std_logic_vector(15 downto 0);
signal I : std_logic;
begin
	
	process(clk,reset)
		variable mem : memory;
		variable ad : integer;
		variable ad1 : integer;
		variable ad2 : integer;
	begin
		
		if(reset = '1') then
			
			AC <= (others => '0');
			DR <= (others => '0');
			IR <= (others => '0');
			PC <= (others => '0');
			AR <= (others => '0');
			TMP <= (others => '0');
			I <= '0';
			state <= "0000";
			--0   000   001010  001010
			mem(0) := "0000000111000111";
			mem(1) := "0000001000001000";
			mem(2) := "0001000111001000";
			mem(3) := "0000001001001001";
			mem(4) := "0000001010001010";
			mem(5) := "0001001001001010";
			mem(6) := "0010000001000101";
			mem(7) := "0001000000000011";
			mem(8) := "0001000000000010";
			mem(9) := "0001000000000011";
			mem(10) := "0001000000000100";
			output <= (others => '0');
		elsif (clk'event and clk = '1') then
		
			case state is
			
				when "0000" =>
					AR <= pc;
					checkstate <= "0000";
					state <= "0001";
				when "0001" =>
					ad := to_integer(unsigned(AR));
					IR <= mem(ad);
					pc <= pc + 1;
					state <= "0010";
					checkstate <= "0001";
				when "0010" =>
					I <= IR(15);
					ad1 := to_integer(unsigned(IR(11 downto 6)));
					ad2 := to_integer(unsigned(IR(5 downto 0)));
					if(IR(14) = '0' and IR(13) = '0' and IR(12) = '0') then
						state <= "0011"; --multiply
					elsif (IR(14) = '0' and IR(13) = '0' and IR(12) = '1') then
						state <= "0100"; --sum
					elsif (IR(14) = '0' and IR(13) = '1' and IR(12) = '0') then
					state <= "0101"; --hlt
					end if;
					checkstate <= "0010";
					
				when "0011" =>
					AC(3 downto 0) <= mem(ad1)(3 downto 0);
					DR(3 downto 0) <= mem(ad2)(3 downto 0);
					state <= "0110";
					checkstate <= "0011";
				when "0100" => 
					AC(7 downto 0) <= mem(ad1)(7 downto 0);
					DR(7 downto 0) <= mem(ad2)(7 downto 0);
					state <= "1000";
					checkstate <= "0100";
				when "0101" =>
					output <= (others => '0');
					checkstate <= "0101";
					state <= "0101";
					when "0110" =>
						AC(7 downto 0) <= std_logic_vector(unsigned(AC(3 downto 0)) * unsigned(DR(3 downto 0)));
						checkstate <= "0110";
						state <= "0111";
					when "0111" => 
						mem(ad1)(7 downto 0) := AC ( 7 downto 0);
						checkstate <= "0111";
						state <= "0000";
					when "1000" =>
						AC(8 downto 0) <= ( '0' & AC (7 downto 0)) + ('0' & DR (7 downto 0));
						checkstate <= "1000";
						state <= "1001";
					when "1001" =>
						output (8 downto 0) <= AC (8 downto 0);
						checkstate <= "1001";
						state <= "0000";
				when others =>
					output <= (others => '0');
					checkstate <= "1111";
			
			end case;
		
		end if;
	
	
	end process;

end Behavioral;

