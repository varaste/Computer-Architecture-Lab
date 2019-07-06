library ieee;
use ieee.std_logic_1164.all;

use work.primitive.all;

entity oddParityGen is
  generic ( width : integer := 8 );
  port (ad: in std_logic_vector (width - 1 downto 0);
        oddParity : out std_logic ) ;
end oddParityGen; 

architecture scaleable of oddParityGen is

signal genXor: std_logic_vector(ad'range);

begin

  genXOR(0) <= '0';

  parTree: for i in 1 to ad'high generate
    x1: xor2 port map (i1 => genXor(i - 1),
                       i2 => ad(i - 1),
                       y  => genXor(i)
                      );
  end generate;

 oddParity <= genXor(ad'high) ;

end scaleable ;
