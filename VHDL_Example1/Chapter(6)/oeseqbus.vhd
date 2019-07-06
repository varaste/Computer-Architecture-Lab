library IEEE;
use IEEE.std_logic_1164.all;

entity TRIBUF8 is port (
  ip: in std_logic_vector(7 downto 0);
  oe: in std_logic;
  op: out std_logic_vector(7 downto 0)
  );
end TRIBUF8;

architecture sequential of TRIBUF8 is

begin

  enable: process (ip,oe) begin
    if (oe = '1') then
      op <= ip;
    else
      op <= (others => 'Z');
    end if;
  end process;

end sequential;
