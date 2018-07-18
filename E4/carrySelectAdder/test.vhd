
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT carrySelect
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         s0 : INOUT  std_logic_vector(3 downto 0);
         s1 : INOUT  std_logic_vector(3 downto 0);
         s2 : OUT  std_logic_vector(3 downto 0);
         cin : IN  std_logic;
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal cin : std_logic := '0';

	--BiDirs
   signal s0 : std_logic_vector(3 downto 0);
   signal s1 : std_logic_vector(3 downto 0);

 	--Outputs
   signal s2 : std_logic_vector(3 downto 0);
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: carrySelect PORT MAP (
          a => a,
          b => b,
          s0 => s0,
          s1 => s1,
          s2 => s2,
          cin => cin,
          cout => cout
        );

  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      

      -- insert stimulus here 
		a <= "0000";
		b <= "0001";
		cin <= '0';
		wait for 100 ns;	
		
		a <= "1000";
		b <= "1001";
		cin <= '0';
		wait for 100 ns;	
		
		
		a <= "0110";
		b <= "1001";
		cin <= '0';
		wait for 100 ns;	

      wait;
   end process;

END;
