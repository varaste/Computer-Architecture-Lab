library IEEE;
use IEEE.std_logic_1164.all;

entity struct_dffe is port (
  d: in std_logic;
  clk: in std_logic;
  en: in std_logic;
  q: out std_logic
  );
end struct_dffe;

use work.primitive.all;

architecture instance of struct_dffe is

begin

  ff: dffe port map (
	d => d,
	clk => clk,
	en => en,
	q => q
      );

end instance;
