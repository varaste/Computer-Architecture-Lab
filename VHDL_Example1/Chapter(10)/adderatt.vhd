library IEEE;
use IEEE.std_logic_1164.all;

entity pAdderAttr is
  generic(n : integer := 8);
  port (a    : in std_logic_vector(n - 1 downto 0);
        b    : in std_logic_vector(n - 1 downto 0);
        cin  : in std_logic;
        sum  : out std_logic_vector(n - 1 downto 0);
        cout : out std_logic);
end pAdderAttr;


architecture loopDemo of pAdderAttr is

begin

  process(a, b, cin)
    variable carry: std_logic_vector(sum'length downto 0);
    variable localSum: std_logic_vector(sum'high downto 0);

  begin

    carry(0) := cin;

    for i in sum'reverse_range loop
      localSum(i)  := (a(i) xor b(i)) xor carry(i);
      carry(i + 1) := (a(i) and b(i)) or (carry(i) and (a(i) or b(i)));
    end loop;

    sum <= localSum;
    cout <= carry(carry'high - 1);

  end process;

end loopDemo;
