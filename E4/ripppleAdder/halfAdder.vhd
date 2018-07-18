
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity halfAdder is
    Port ( ai : in  STD_LOGIC;
           bi : in  STD_LOGIC;
           s : out  STD_LOGIC;
           c : out  STD_LOGIC);
end halfAdder;

architecture Behavioral of halfAdder is

begin

s <= ai xor bi;
c <= ai and bi;

end Behavioral;

