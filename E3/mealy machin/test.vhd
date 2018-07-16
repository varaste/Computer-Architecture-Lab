
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mealy
    PORT(
         input : IN  std_logic;
         clk : IN  std_logic;
         output : OUT  std_logic;
         output_string : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal output : std_logic;
   signal output_string : std_logic_vector(4 downto 0);

  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mealy PORT MAP (
          input => input,
          clk => clk,
          output => output,
          output_string => output_string
        );

       process begin
	clk <= '0' ; wait for 5 ns;
	clk <= '1' ; wait for 5 ns;
   end process;
 

   process begin		
		input <= '0';
		wait for 5 ns;
		input <= '0';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';	
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '1';
		wait for 10 ns;
		input <= '0';
		wait for 10 ns;
		input <= '1';

      wait;
   end process;

END;
