library IEEE;
use IEEE.std_logic_1164.all;

entity TRIBUF is port (
  ip: in std_logic;
  oe: in std_logic;
  op: out std_logic
  );
end TRIBUF;

architecture sequential of TRIBUF is

begin

  enable: process (ip,oe) begin
    if (oe = '1') then
      op <= ip;
    else
      op <= 'Z';
    end if;
  end process;

end sequential;
