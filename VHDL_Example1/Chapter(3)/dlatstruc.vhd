library IEEE;
use IEEE.std_logic_1164.all;

entity struct_dlatch is port (
  d: in std_logic;
  en: in std_logic;
  q: out std_logic
  );
end struct_dlatch;

use work.primitive.all;

architecture instance of struct_dlatch is

begin

  latch: dlatchh port map (
	d => d,
	en => en,
	q => q
      );

end instance;
