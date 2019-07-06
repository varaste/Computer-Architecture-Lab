library IEEE;
USE IEEE.std_logic_1164.all;

package simPrimitives is

  component OR2
    generic (tPD: time := 1 ns);

    port (I1, I2: in std_logic;
      Y: out std_logic
      );
  end component;

end simPrimitives;


library IEEE;
USE IEEE.std_logic_1164.all;

entity OR2 is
  generic (tPD: time := 1 ns);

  port (I1, I2: in std_logic;
    Y: out std_logic
    );
end OR2;

architecture simple of OR2 is

begin

  Y <= I1 OR I2 after tPD;

end simple;
