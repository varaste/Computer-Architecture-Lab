library IEEE;
use IEEE.std_logic_1164.all;

entity regFile is port (
  clk, rst: in std_logic;
  data: in std_logic_vector(31 downto 0);
  regSel: in std_logic_vector(1 downto 0);
  wrEnable: in std_logic;
  regOut: out std_logic_vector(31 downto 0)
  );
end regFile;

architecture behavioral of regFile is

subtype reg is std_logic_vector(31 downto 0);
type regArray is array (integer range <>) of reg;

signal registerFile: regArray(0 to 3);

begin

  regProc: process (clk, rst) 
  variable i: integer;

  begin
    i := 0;

    if rst = '1' then
      while i <= registerFile'high loop
        registerFile(i) <= (others => '0');
        i := i + 1;
      end loop;

    elsif clk'event and clk = '1' then
      if (wrEnable = '1') then
        case regSel is
          when "00" =>
            registerFile(0) <= data;
          when "01" =>
            registerFile(1) <= data;
          when "10" =>
            registerFile(2) <= data;
          when "11" =>
            registerFile(3) <= data;
          when others =>
            null;
        end case;
      end if;
    end if;
  end process;

  outputs: process(regSel, registerFile) begin
    case regSel is
      when "00" =>
        regOut <= registerFile(0);
      when "01" =>
        regOut <= registerFile(1);
      when "10" =>
        regOut <= registerFile(2);
      when "11" =>
        regOut <= registerFile(3);
      when others =>
        null;
    end case;
  end process;

end behavioral;
