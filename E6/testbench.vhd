LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY testbench IS
END testbench;
 
ARCHITECTURE behavior OF testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT myregister
    PORT(
         parallel_in : IN  std_logic_vector(3 downto 0);
         L_R : IN  std_logic_vector(1 downto 0);
         serial_in : IN  std_logic;
         load : IN  std_logic;
         reset : IN  std_logic;
         clk : IN  std_logic;
         reg_out : INOUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal parallel_in : std_logic_vector(3 downto 0) := (others => '0');
   signal L_R : std_logic_vector(1 downto 0) := (others => '0');
   signal serial_in : std_logic := '0';
   signal load : std_logic := '0';
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';

	--BiDirs
   signal reg_out : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: myregister PORT MAP (
          parallel_in => parallel_in,
          L_R => L_R,
          serial_in => serial_in,
          load => load,
          reset => reset,
          clk => clk,
          reg_out => reg_out
        );

 process begin
	clk <= '0' ; wait for 5 ns;
	clk <= '1' ; wait for 5 ns;
end process;

  process begin		
      reset <= '1';
		wait for 10 ns;
		reset <= '0';
		wait for 10 ns;
		load <= '1';
		parallel_in <= "1001";
		wait for 10 ns;
		load <= '0';
		L_R <= "00";
		serial_in <= '0';
		wait for 10 ns;
		load <= '0';
		L_R <= "01";
		serial_in <= '0';
		wait for 10 ns;
		load <= '0';
		L_R <= "10";
		serial_in <= '0';
		wait for 10 ns;
		load <= '0';
		L_R <= "11";
		serial_in <= '0';
		
		
		
      wait;
   end process;

END behavior;
