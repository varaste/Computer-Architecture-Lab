library IEEE;
use IEEE.std_logic_1164.all;

entity mux is port (
  A, B, Sel: in std_logic;
  Y: out std_logic
  );
end mux;

architecture simModel of mux is

-- Delay Constants
constant tPD_A:   time := 10 ns;
constant tPD_B:   time := 15 ns;
constant tPD_Sel: time := 5 ns;

begin

  DelayMux: process (A, B, Sel)

  variable localY: std_logic; -- Zero delay place holder for Y

  begin

  -- Zero delay model
    case Sel is
      when '0' =>
        localY := A;
      when others =>
        localY := B;
    end case;

  -- Delay calculation
    if (B'event) then
      Y <= localY after tPD_B;
    elsif (A'event) then
      Y <= localY after tPD_A;
    else
      Y <= localY after tPD_Sel;
    end if;

  end process;


end simModel;
