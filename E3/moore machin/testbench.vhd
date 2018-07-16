
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT moore
    PORT(
         clk : IN  std_logic;
         input : IN  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal input : std_logic := '0';

 	--Outputs
   signal output : std_logic;

   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: moore PORT MAP (
          clk => clk,
          input => input,
          output => output
        );

   
  process begin
	clk <= '0' ; wait for 5 ns;
	clk <= '1' ; wait for 5 ns;
   end process;
 

   process begin		
      input <= '0';
		wait for 4 ns;
		input <= '1';
		wait for 4 ns;
		input <= '1';
		wait for 4 ns;
		input <= '0';
		wait for 4 ns;
		input <= '1';
		wait for 4 ns;
		input <= '1';
		wait for 4 ns;

      wait;
   end process;

END;
