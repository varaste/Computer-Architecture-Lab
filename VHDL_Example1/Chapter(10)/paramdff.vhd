library IEEE;
use IEEE.std_logic_1164.all;

use work.primitive.all;

entity paramDFF is
  generic (size: integer := 8);
  port (
  data: in std_logic_vector(size - 1 downto 0);
  clock: in std_logic;
  reset: in std_logic;
  ff_enable: in std_logic;
  op_enable: in std_logic;
  qout: out std_logic_vector(size - 1 downto 0)
  );
end paramDFF;

architecture parameterize of paramDFF is

signal reg: std_logic_vector(size - 1 downto 0);

begin

  u1: pDFFE generic map (n => size)
            port map    (d => data,
                         clk =>clock,
                         rst => reset,
                         en => ff_enable,
                         q => reg
                        );
  u2: pTRIBUF generic map (n => size)
              port map    (ip => reg,
                           oe => op_enable,
                           op => qout
                          );

end paramterize;
