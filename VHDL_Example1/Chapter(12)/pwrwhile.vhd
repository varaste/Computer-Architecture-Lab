library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

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

       power <= conv_std_logic_vector(Pow(conv_integer(inputVal),4),16);
   
   end process;

end behavioral;
