library IEEE;
USE IEEE.std_logic_1164.all;

package simPrimitives is

  component OR2
    generic (tPD: time := 1 ns);

    port (I1, I2: in std_logic;
          Y: out std_logic
         );
  end component;

  component SimDFF
  generic(tCQ: time := 1 ns;
          tS : time := 1 ns;
          tH : time := 1 ns
         );
  port (D, Clk: in std_logic;
        Q: out std_logic
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



library IEEE;
use IEEE.std_logic_1164.all;

entity SimDFF is
  generic(tCQ: time := 1 ns;
          tS : time := 1 ns;
          tH : time := 1 ns
         );
  port (D, Clk: in std_logic;
  Q: out std_logic
  );
end SimDff;

architecture SimModel of SimDFF is

begin

  reg: process (Clk, D) begin

    -- Assign output tCQ after rising clock edge
    if (Clk'event and Clk = '1') then
      Q <= D after tCQ;
    end if;

    -- Check setup time
    if (Clk'event and Clk = '1') then
      assert (D'last_event >= tS)
        report "Setup time violation"
        severity Warning;
    end if;

    -- Check hold time
    if (D'event and Clk'stable and Clk = '1') then
      assert (D'last_event - Clk'last_event > tH)
        report "Hold Time Violation"
        severity Warning;
    end if;

  end process;

end simModel;

