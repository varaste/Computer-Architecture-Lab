library ieee;
use ieee.std_logic_1164.all;
entity encoder is
        port (invec: in std_logic_vector(7 downto 0);
              enc_out: out std_logic_vector(2 downto 0)
             );
end encoder;

architecture rtl of encoder is

begin

  encode: process (invec) begin
    case invec is
      when "00000001" =>
        enc_out <= "000";

      when "00000010" =>
        enc_out <= "001";

      when "00000100" =>
        enc_out <= "010";

      when "00001000" =>
        enc_out <= "011";

      when "00010000" =>
        enc_out <= "100";

      when "00100000" =>
        enc_out <= "101";

      when "01000000" =>
        enc_out <= "110";

      when "10000000" =>
        enc_out <= "111";

      when others =>
        enc_out <= "000";

      end case;
    end process;

end rtl;
