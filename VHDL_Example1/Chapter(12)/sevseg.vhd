library ieee;
use ieee.std_logic_1164.all;

entity sevenSegment is port (
  bcdInputs: in std_logic_vector (3 downto 0);
  a_n, b_n, c_n, d_n,
  e_n, f_n, g_n: out std_logic
  );
end sevenSegment;

architecture behavioral of sevenSegment is
-- LED segment..........................................abcdefg
constant DefaultValue: std_logic_vector(6 downto 0) := "1111111";
constant zero        : std_logic_vector(6 downto 0) := "0000001";
constant one         : std_logic_vector(6 downto 0) := "1001111";
constant two         : std_logic_vector(6 downto 0) := "0010010";
constant three       : std_logic_vector(6 downto 0) := "0000110";
constant four        : std_logic_vector(6 downto 0) := "1001100";
constant five        : std_logic_vector(6 downto 0) := "0100100";
constant six         : std_logic_vector(6 downto 0) := "0100000";
constant seven       : std_logic_vector(6 downto 0) := "0001111";
constant eight       : std_logic_vector(6 downto 0) := "0000000";
constant nine        : std_logic_vector(6 downto 0) := "0000100";

begin

  bcd2sevSeg: process (bcdInputs) begin

  -- Assign default to "off"
  (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= defaultValue;

    case bcdInputs is
      when "0000" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= zero;

      when "0001" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= one;

      when "0010" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= two;

      when "0011" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= three;

      when "0100" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= four;

      when "0101" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= five;

      when "0110" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= six;

      when "0111" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= seven;

      when "1000" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= eight;

      when "1001" =>
       (a_n, b_n, c_n, d_n, e_n, f_n, g_n) <= nine;

      when others =>
        null;

    end case;

  end process bcd2sevSeg;

end behavioral;
