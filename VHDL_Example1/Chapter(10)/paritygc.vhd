library ieee;
use ieee.std_logic_1164.all;

use work.primitive.all;

entity oddParityGen is
  generic ( width : integer := 32 );
  port (ad: in std_logic_vector (width - 1 downto 0);
        oddParity : out std_logic ) ;
end oddParityGen; 

architecture scaleable of oddParityGen is

signal genXor: std_logic_vector(ad'range);

signal one: std_logic := '1';

begin

  parTree: for i in ad'range generate
    g0: if i = 0 generate
      x0: xor2 port map (i1 => one,
                         i2 => one,
                         y => genXor(0)
                        );
    end generate;

    g1: if i > 0 and i <= ad'high generate
      x1: xor2 port map (i1 => genXor(i - 1),
                         i2 => ad(i - 1),
                         y  => genXor(i)
                        );
    end generate;

  end generate;

 oddParity <= genXor(ad'high) ;

end scaleable ;
