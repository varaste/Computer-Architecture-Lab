library IEEE;
use IEEE.std_logic_1164.all;

entity pAdder is
  generic(n : integer := 8);
  port (a    : in std_logic_vector(n - 1 downto 0);
        b    : in std_logic_vector(n - 1 downto 0);
        cin  : in std_logic;
        sum  : out std_logic_vector(n - 1 downto 0);
        cout : out std_logic);
end pAdder;


architecture loopDemo of pAdder is

begin

  process(a, b, cin)
    variable carry: std_logic_vector(n downto 0);
    variable localSum: std_logic_vector(n - 1 downto 0);

  begin

    carry(0) := cin;

    for i in 0 to n - 1 loop
      localSum(i)  := (a(i) xor b(i)) xor carry(i);
      carry(i + 1) := (a(i) and b(i)) or (carry(i) and (a(i) or b(i)));
    end loop;

    sum <= localSum;
    cout <= carry(n - 1);

  end process;

end loopDemo;
