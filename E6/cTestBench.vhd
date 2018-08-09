
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY cTestBench IS
END cTestBench;
 
ARCHITECTURE behavior OF cTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         Qout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Qout : std_logic;

   -- Clock period definitions
   --constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter PORT MAP (
          reset => reset,
          clk => clk,
          Qout => Qout
        );

  process begin
	clk <= '0' ; wait for 5 ns;
	clk <= '1' ; wait for 5 ns;
end process;
 

  process begin		
      reset <= '1';
		wait for 10 ns;
		reset <= '0';
		
		
      wait;
   end process;

END;
