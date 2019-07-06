package PowerPkg is  
  component Power port(
      Clk                   : in  bit; 
      inputVal              : in  bit_vector(0 to 3);
      power                 : out bit_vector(0 to 15) );
   end component;
end          PowerPkg;

use work.bv_math.all;
use work.int_math.all;
use work.PowerPkg.all;

entity Power is port(
   Clk                   : in  bit; 
   inputVal              : in  bit_vector(0 to 3);
   power                 : out bit_vector(0 to 15) );
end    Power;




architecture funky of Power is
   
   function Pow( N, Exp : integer )  return integer is
      Variable Result   : integer := 1;
      Variable i        : integer := 0;
   begin
      while( i < Exp ) loop
         Result := Result * N;
         i      := i      + 1;
      end loop;
      return( Result );
   end Pow;
   
   
   function RollVal(  CntlVal : integer )  return integer is
   begin
      return( Pow( 2, CntlVal ) + 2 );
   end RollVal;
   
   
begin
   process 
   begin
      wait until Clk = '1';
         
        power <= i2bv(Rollval(bv2I(inputVal)),16);
   
   end process;
end funky;
