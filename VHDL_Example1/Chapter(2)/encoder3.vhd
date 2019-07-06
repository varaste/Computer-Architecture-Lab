library ieee;
use ieee.std_logic_1164.all;
entity encoder is
  port (invec: in std_logic_vector(7 downto 0);
        enc_out: out std_logic_vector(2 downto 0)
        );
end encoder;

architecture rtl of encoder is

begin
  enc_out <= "111" when invec(7) = '1' else
             "110" when invec(6) = '1' else
             "101" when invec(5) = '1' else
             "100" when invec(4) = '1' else
             "011" when invec(3) = '1' else
             "010" when invec(2) = '1' else
             "001" when invec(1) = '1' else
             "000" when invec(0) = '1' else
             "000";

end rtl;
