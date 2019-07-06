library IEEE;
use IEEE.std_logic_1164.all;

entity flipFlop is port (
  clock, input: in std_logic;
  ffOut: out std_logic
  );
end flipFlop;

architecture simple of flipFlop is

  procedure dff (signal clk: in std_logic;
                 signal d: in std_logic;
                 signal q: out std_logic
                ) is
  begin
    if clk'event and clk = '1' then
      q <= d;
    end if;
  end procedure dff;

begin

  dff(clock, input, ffOut);

end simple;

