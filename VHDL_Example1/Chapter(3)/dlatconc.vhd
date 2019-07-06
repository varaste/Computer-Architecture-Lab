library IEEE;
use IEEE.std_logic_1164.all;

entity DLATCHH is port (
    d: in std_logic;
    en: in std_logic;
    q: out std_logic
    );
end DLATCHH;

architecture rtl of DLATCHH is

signal qLocal: std_logic;

begin

  qLocal <= d when en = '1' else qLocal;

  q <= qLocal;

end rtl;
