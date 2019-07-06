library IEEE;
use IEEE.std_logic_1164.all;

entity TRIBUF is port (
  ip: in bit;
  oe: in bit;
  op: out bit
  );
end TRIBUF;

architecture sequential of TRIBUF is

begin

  enable: process (ip,oe) begin
    if (oe = '1') then
      op <= ip;
    else
      op <= null;
    end if;
  end process;

end sequential;
