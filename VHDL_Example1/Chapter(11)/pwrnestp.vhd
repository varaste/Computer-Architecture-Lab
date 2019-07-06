-- Incorporates errata 5.4

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.specialFunctions.all;

entity powerOfFour is port(
  clk      : in  std_logic; 
  inputVal : in  std_logic_vector(3 downto 0);
  power    : out std_logic_vector(15 downto 0)
  );
end powerOfFour;

architecture behavioral of powerOfFour is

begin

   process begin
     wait until Clk = '1';

       power <= std_logic_vector(to_unsigned(Pow(to_integer(unsigned(inputVal)),4),16));
   
   end process;

end behavioral;
