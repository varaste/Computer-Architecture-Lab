library IEEE;
use IEEE.std_logic_1164.all;

entity SimDFF is port (
  D, Clk: in std_logic;
  Q: out std_logic
  );
end SimDff;

architecture SimModel of SimDFF is

constant tCQ: time := 8 ns;
constant tS:  time := 4 ns;
constant tH:  time := 3 ns;

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
