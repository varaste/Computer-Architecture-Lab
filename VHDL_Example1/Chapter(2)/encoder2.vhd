library ieee;
use ieee.std_logic_1164.all;

entity encoder is
  port (invec:in std_logic_vector(7 downto 0);
        enc_out:out  std_logic_vector(2 downto 0)
       );
end encoder;

architecture rtl of encoder is
begin
  process (invec)
    begin
      if invec(7) = '1' then
        enc_out <= "111";

      elsif invec(6) = '1' then
        enc_out <= "110";

      elsif invec(5) = '1' then
        enc_out <= "101";

      elsif invec(4) = '1' then
        enc_out <= "100";

      elsif invec(3) = '1' then
        enc_out <= "011";

      elsif invec(2) = '1' then
        enc_out <= "010";

      elsif invec(1) = '1' then
        enc_out <= "001";

      elsif invec(0) = '1' then
        enc_out <= "000";

      else 
        enc_out <= "000";
      end if; 
    end process;
end rtl;

