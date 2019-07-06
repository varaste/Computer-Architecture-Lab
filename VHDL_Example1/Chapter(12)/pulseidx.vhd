library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity progPulseFsm is port (
  downCnt: in std_logic_vector(7 downto 0);
  delayCntVal: in std_logic_vector(7 downto 0);
  lengthCntVal: in std_logic_vector(7 downto 0);
  loadLength: in std_logic;
  loadDelay: in std_logic;
  clk: in std_logic;
  reset: in std_logic;

  downCntEn: out std_logic;
  downCntLd: out std_logic;
  downCntData: out std_logic_vector(7 downto 0);

  pulse: out std_logic
  );
end progPulseFsm;

architecture fsm of progPulseFsm is

type progPulseFsmType is (loadDelayCnt, waitDelayEnd, loadLengthCnt, waitLengthEnd);
type stateVec is array (3 downto 0) of std_logic;
type stateBits is array (progPulseFsmType) of stateVec;

signal loadVal: std_logic;

constant stateTable: stateBits := (
  loadDelayCnt =>  "0010",
  waitDelayEnd =>  "0100",
  loadLengthCnt => "0011",
  waitLengthEnd => "1101" );
--                  ^^^^
--                  ||||__ loadVal   
--                  |||___ downCntLd
--                  ||____ downCntEn
--                  |_____ pulse

signal currState, nextState: progPulseFsmType;

begin

  nextStProc: process (currState, downCnt, loadDelay, loadLength) begin
    case currState is
      when loadDelayCnt =>
        nextState <= waitDelayEnd;

      when waitDelayEnd =>
        if (loadDelay = '1' or loadLength = '1') then
          nextState <= loadDelayCnt;
        elsif (to_unsigned(downCnt) = 0) then
          nextState <= loadLengthCnt;
        else
          nextState <= waitDelayEnd;
        end if;

      when loadLengthCnt =>
        if (loadDelay = '1' or loadLength = '1') then
          nextState <= loadDelayCnt;
        else
          nextState <= waitLengthEnd;
        end if;

      when waitLengthEnd =>
        if (loadDelay = '1' or loadLength = '1') then
          nextState <= loadDelayCnt;
        elsif (to_unsigned(downCnt) = 0) then
          nextState <= loadDelayCnt;
        else
          nextState <= waitDelayEnd;
        end if;

      when others =>
        null;

   end case;

  end process nextStProc;

  currStProc: process (clk, reset) begin
    if (reset = '1') then
      currState <= loadDelayCnt;
    elsif (clk'event and clk = '1') then
      currState <= nextState;
    end if;
  end process currStProc;

  pulse     <= stateTable(currState)(3);
  downCntEn <= stateTable(currState)(2);
  downCntLd <= stateTable(currState)(1);
  loadVal   <= stateTable(currState)(0);
  
  downCntData <= delayCntVal when loadVal = '0' else lengthCntVal;

end fsm;
