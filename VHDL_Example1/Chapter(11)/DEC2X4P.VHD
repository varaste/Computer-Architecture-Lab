library IEEE;
use IEEE.std_logic_1164.all;

entity decoder is port (
  decIn: in std_logic_vector(1 downto 0);
  decOut: out std_logic_vector(3 downto 0)
  );
end decoder;

architecture simple of decoder is

  procedure DEC2x4 (inputs : in std_logic_vector(1 downto 0);
                    decode: out std_logic_vector(3 downto 0)
                   ) is
  begin
    case inputs is
      when "11" =>
        decode := "1000";
      when "10" =>
        decode := "0100";
      when "01" =>
        decode := "0010";
      when "00" =>
        decode := "0001";
      when others =>
        decode := "0001";
    end case;
  end DEC2x4;

begin

  DEC2x4(decIn,decOut);

end simple;

