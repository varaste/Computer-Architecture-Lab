library ieee;
use ieee.std_logic_1164.all;

use work.primitive.all;

entity oddParityGen is
  generic ( width : integer := 32 ); -- (2 <= width <= 32) and a power of 2
  port (ad: in std_logic_vector (width - 1 downto 0);
        oddParity : out std_logic ) ;
end oddParityGen; 

architecture scaleable of oddParityGen is

signal stage0: std_logic_vector(31 downto 0);
signal stage1: std_logic_vector(15 downto 0);
signal stage2: std_logic_vector(7 downto 0);
signal stage3: std_logic_vector(3 downto 0);
signal stage4: std_logic_vector(1 downto 0);

begin

  g4: for i in stage4'range generate
    g41: if (ad'length > 2) generate
         x4: xor2 port map (stage3(i), stage3(i + stage4'length), stage4(i));
    end generate;
  end generate;

  g3: for i in stage3'range generate
    g31: if (ad'length > 4) generate
         x3: xor2 port map (stage2(i), stage2(i + stage3'length), stage3(i));
    end generate;
  end generate;

  g2: for i in stage2'range generate
    g21: if (ad'length > 8) generate
         x2: xor2 port map (stage1(i), stage1(i + stage2'length), stage2(i));
    end generate;
  end generate;

  g1: for i in stage1'range generate
    g11: if (ad'length > 16) generate
         x1: xor2 port map (stage0(i), stage0(i + stage1'length), stage1(i));
    end generate;
  end generate;


  s1: for i in ad'range generate
    s14: if (ad'length = 2) generate
         stage4(i) <= ad(i);
    end generate;

    s13: if (ad'length = 4) generate
         stage3(i) <= ad(i);
    end generate;

    s12: if (ad'length = 8) generate
         stage2(i) <= ad(i);
    end generate;

    s11: if (ad'length = 16) generate
         stage1(i) <= ad(i);
    end generate;

    s10: if (ad'length = 32) generate
         stage0(i) <= ad(i);
    end generate;

  end generate;


  genPar: xor2 port map (stage4(0), stage4(1), oddParity);

end scaleable ;
