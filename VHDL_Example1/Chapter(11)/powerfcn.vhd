library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity powerOfFour is port(
  clk      : in  std_logic; 
  inputVal : in  unsigned(3 downto 0);
  power    : out unsigned(15 downto 0)
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

signal inputValInt: integer range 0 to 15;
signal powerL: integer range 0 to 65535;
   
begin

   inputValInt <= to_integer(inputVal);
   power <= to_unsigned(powerL,16);

   process begin
     wait until Clk = '1';

       powerL <= Pow(inputValInt,4);
   
   end process;

end behavioral;
