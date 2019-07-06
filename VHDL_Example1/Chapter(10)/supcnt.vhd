library IEEE;
use IEEE.std_logic_1164.all;

package scaleable is
  component scaleUpCnt port (
    clk: in std_logic;
    reset: in std_logic;
    cnt: in std_logic_vector
    );
  end component;
end scaleable;

library IEEE;
use IEEE.std_logic_1164.all;

use work.primitive.all;

entity scaleUpCnt is port (
  clk: in std_logic;
  reset: in std_logic;
  cnt: out std_logic_vector
  );
end scaleUpCnt;

architecture scaleable of scaleUpCnt is

signal one: std_logic := '1';
signal cntL: std_logic_vector(cnt'range);
signal andTerm: std_logic_vector(cnt'range);

begin

-- Special case is the least significant bit

  lsb: tff port map (t => one,
                     reset => reset,
                     clk => clk,
                     q => cntL(cntL'low)
                    );

  andTerm(0) <= cntL(cntL'low);


-- General case for all other bits

  genAnd: for i in 1 to cntL'high generate
    andTerm(i) <= andTerm(i - 1) and cntL(i);
  end generate;

  genTFF: for i in 1 to cntL'high generate
    t1: tff port map (t => andTerm(i),
                      clk => clk,
                      reset => reset,
                      q => cntl(i)
                     );
  end generate;

  cnt <= CntL;

end scaleable;
