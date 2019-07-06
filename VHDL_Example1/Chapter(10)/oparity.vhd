library ieee;
use ieee.std_logic_1164.all;

entity oddParityLoop is
  generic ( width : integer := 8 );
  port (ad: in std_logic_vector (width - 1 downto 0);
        oddParity : out std_logic ) ;
end oddParityLoop ; 

architecture scaleable of oddParityLoop is
begin

  process (ad) 
    variable loopXor: std_logic;
  begin
    loopXor := '0';

    for i in 0 to width -1 loop
        loopXor := loopXor xor ad( i ) ;
    end loop ;

    oddParity <= loopXor ;

  end process;

end scaleable ;
