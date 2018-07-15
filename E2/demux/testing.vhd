
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY testing IS
END testing;
 
ARCHITECTURE behavior OF testing IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT demuxfour
    PORT(
         f : IN  std_logic_vector(3 downto 0);
         b0 : IN  std_logic;
         b1 : IN  std_logic;
         a0 : OUT  std_logic_vector(3 downto 0);
         a1 : OUT  std_logic_vector(3 downto 0);
         a2 : OUT  std_logic_vector(3 downto 0);
         a3 : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal f : std_logic_vector(3 downto 0) := (others => '0');
   signal b0 : std_logic := '0';
   signal b1 : std_logic := '0';

 	--Outputs
   signal a0 : std_logic_vector(3 downto 0);
   signal a1 : std_logic_vector(3 downto 0);
   signal a2 : std_logic_vector(3 downto 0);
   signal a3 : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: demuxfour PORT MAP (
          f => f,
          b0 => b0,
          b1 => b1,
          a0 => a0,
          a1 => a1,
          a2 => a2,
          a3 => a3
        );

  

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      

      -- insert stimulus here 
		f <= "0111";
		b0 <= '0';
		b1 <= '1';
      wait;
   end process;

END;
