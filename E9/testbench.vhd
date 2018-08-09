LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT computer
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         output : OUT  std_logic_vector(11 downto 0);
         checkstate : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(11 downto 0);
   signal checkstate : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: computer PORT MAP (
          clk => clk,
          reset => reset,
          output => output,
          checkstate => checkstate
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		reset <= '1';
		wait for 10 ns;
		reset <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
