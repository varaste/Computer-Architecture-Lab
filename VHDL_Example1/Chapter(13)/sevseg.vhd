library ieee;
use ieee.std_logic_1164.all;

entity sevenSegment is port (
  bcdInputs: in std_logic_vector (3 downto 0);
  a_n, b_n, c_n, d_n,
  e_n, f_n, g_n: out std_logic
  );
end sevenSegment;

architecture behavioral of sevenSegment is

begin

  bcd2sevSeg: process (bcdInputs) begin

  -- Assign default to "off"
    a_n <= '1';    b_n <= '1';
    c_n <= '1';    d_n <= '1';
    e_n <= '1';    f_n <= '1';
    g_n <= '1';

    case bcdInputs is
      when "0000" =>
        a_n <= '0';        b_n <= '0';
        c_n <= '0';        d_n <= '0';
        e_n <= '0';        f_n <= '0';

      when "0001" =>
        b_n <= '0';        c_n <= '0';

      when "0010" =>
        a_n <= '0';        b_n <= '0';
        d_n <= '0';        e_n <= '0';
        g_n <= '0';

      when "0011" =>
        a_n <= '0';        b_n <= '0';
        c_n <= '0';        d_n <= '0';
        g_n <= '0';

      when "0100" =>
        b_n <= '0';        c_n <= '0';
        f_n <= '0';        g_n <= '0';

      when "0101" =>
        a_n <= '0';        c_n <= '0';
        d_n <= '0';        f_n <= '0';
        g_n <= '0';

      when "0110" =>
        a_n <= '0';        c_n <= '0';
        d_n <= '0';        e_n <= '0';
        f_n <= '0';        g_n <= '0';

      when "0111" =>
        a_n <= '0';        b_n <= '0';
        c_n <= '0';

      when "1000" =>
        a_n <= '0';        b_n <= '0';
        c_n <= '0';        d_n <= '0';
        e_n <= '0';        f_n <= '0';
        g_n <= '0';

      when "1001" =>
        a_n <= '0';        b_n <= '0';
        c_n <= '0';        d_n <= '0';
        f_n <= '0';        g_n <= '0';

      when others =>
        null;

    end case;

  end process bcd2sevSeg;

end behavioral;
