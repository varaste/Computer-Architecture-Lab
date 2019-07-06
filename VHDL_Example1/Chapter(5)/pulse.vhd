-- Incorporates Errata 6.1

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
  downtCntData: out std_logic_vector(7 downto 0);

  pulse: out std_logic
  );
end progPulseFsm;

architecture fsm of progPulseFsm is

type progPulseFsmType is (loadDelayCnt, waitDelayEnd, loadLengthCnt, waitLengthEnd);
signal currState, nextState: progPulseFsmType;
signal downCntL: unsigned (7 downto 0);

begin

  downCntL <= to_unsigned(downCnt); -- convert downCnt to unsigned

  nextStProc: process (currState, downCntL, loadDelay, loadLength) begin
    case currState is
      when loadDelayCnt =>
        nextState <= waitDelayEnd;

      when waitDelayEnd =>
        if (loadDelay = '1' or loadLength = '1') then
          nextState <= loadDelayCnt;
        elsif (downCntL = 0) then
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
        elsif (downCntL = 0) then
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

  outConProc: process (currState, delayCntVal, lengthCntVal) begin
    case currState is
      when loadDelayCnt =>
        downCntEn <= '0';
        downCntLd <= '1';
        downtCntData <= delayCntVal;
        pulse <= '0';

      when waitDelayEnd =>
        downCntEn <= '1';
        downCntLd <= '0';
        downtCntData <= delayCntVal;
        pulse <= '0';

      when loadLengthCnt =>
        downCntEn <= '0';
        downCntLd <= '1';
        downtCntData <= lengthCntVal;
        pulse <= '1';

      when waitLengthEnd =>
        downCntEn <= '1';
        downCntLd <= '0';
        downtCntData <= lengthCntVal;
        pulse <= '1';

      when others =>
        downCntEn <= '0';
        downCntLd <= '1';
        downtCntData <= delayCntVal;
        pulse <= '0';

    end case;
  end process outConProc;

end fsm;
