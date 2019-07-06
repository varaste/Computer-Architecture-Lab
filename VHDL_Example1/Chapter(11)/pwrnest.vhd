-- Incorporate errata 5.4

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity powerOfFour is port(
  clk      : in  std_logic; 
  inputVal : in  std_logic_vector(3 downto 0);
  power    : out std_logic_vector(15 downto 0)
  );
end powerOfFour;

architecture behavioral of powerOfFour is

   function Pow( N, Exp : integer )  return integer is
      Variable Result   : integer := 1;

   begin
      for i in 1 to Exp loop
         Result := Result * N;
      end loop;
      return( Result );
   end Pow;

begin

   process begin
     wait until Clk = '1';

       power <= std_logic_vector(to_unsigned(Pow(to_integer(to_unsigned(inputVal)),4),16));
   
   end process;

end behavioral;
