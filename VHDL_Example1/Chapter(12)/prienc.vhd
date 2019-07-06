library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority_encoder is port
  (interrupts : in  std_logic_vector(7 downto 0);
   priority   : in  std_logic_vector(2 downto 0);
   result     : out std_logic_vector(2 downto 0)
  );
end priority_encoder;

architecture behave of priority_encoder is
begin

  process (interrupts)
     variable selectIn  : integer;
     variable LoopCount : integer;
  begin

    LoopCount   := 1;
    selectIn := to_integer(to_unsigned(priority));
      
      while (LoopCount <= 7) and (interrupts(selectIn) /= '0') loop
		
        if (selectIn = 0) then
          selectIn := 7;
        else
          selectIn := selectIn - 1;
        end if;
			
        LoopCount := LoopCount + 1;
  
      end loop;
		
    result <= std_logic_vector(to_unsigned(selectIn,3));

  end process;
  
end behave;
