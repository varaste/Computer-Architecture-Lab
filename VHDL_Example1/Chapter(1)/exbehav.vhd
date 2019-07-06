library IEEE;
use IEEE.std_logic_1164.all;

entity LogicFcn is port (
  A: in std_logic;
  B: in std_logic;
  C: in std_logic;
  Y: out std_logic
  );
end LogicFcn;

architecture behavioral of LogicFcn is

begin

  fcn: process (A,B,C) begin

    if (A = '0' and B = '0') then
      Y <= '1';
    elsif C = '1' then
      Y <= '1';
    else
      Y <= '0';
    end if;

  end process;

end behavioral;
