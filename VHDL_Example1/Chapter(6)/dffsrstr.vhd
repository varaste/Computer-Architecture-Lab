library IEEE;
use IEEE.std_logic_1164.all;

entity struct_dffe_sr is port (
  d: in std_logic;
  clk: in std_logic;
  en: in std_logic;
  rst,prst: in std_logic;
  q: out std_logic
  );
end struct_dffe_sr;

use work.primitive.all;

architecture instance of struct_dffe_sr is

begin

  ff: dffe_sr port map (
	d => d,
	clk => clk,
	en => en,
        rst => rst,
        prst => prst,
	q => q
    );

end instance;
