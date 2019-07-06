library IEEE;
use IEEE.std_logic_1164.all;

use work.primitive.all;

entity dffTri is
  generic (size: integer := 8);
  port (
  data: in std_logic_vector(size - 1 downto 0);
  clock: in std_logic;
  ff_enable: in std_logic;
  op_enable: in std_logic;
  qout: out std_logic_vector(size - 1 downto 0)
  );
end dffTri;

architecture parameterize of dffTri is

type tribufType is record
  ip: std_logic;
  oe: std_logic;
  op: std_logic;
end record;

type tribufArrayType is array (integer range <>) of tribufType;

signal tri: tribufArrayType(size - 1 downto 0);

begin

  g0: for i in 0 to size - 1 generate
    u1: DFFE port map (data(i), tri(i).ip, ff_enable, clock);
  end generate;

  g1: for i in 0 to size - 1 generate
    u2: TRIBUF port map (tri(i).ip, tri(i).oe, tri(i).op);
    tri(i).oe <= op_enable;
    qout(i) <= tri(i).op;
  end generate;

end parameterize;
