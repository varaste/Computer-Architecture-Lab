library ieee;
use ieee.std_logic_1164.all;

use std.textio.all;

entity sevenSegmentTB is
end sevenSegmentTB;

architecture testbench of sevenSegmentTB is

component sevenSegment port (
  bcdInputs: in std_logic_vector (3 downto 0);
  a_n, b_n, c_n, d_n,
  e_n, f_n, g_n: out std_logic
  );
end component;

type vector is record
  bcdStimulus: std_logic_vector(3 downto 0);
  sevSegOut: std_logic_vector(6 downto 0);
end record;

constant NumVectors: integer:= 17;
constant PropDelay: time := 40 ns;
constant SimLoopDelay: time := 10 ns;

type vectorArray is array (0 to NumVectors - 1) of vector;
constant vectorTable: vectorArray := (
  (bcdStimulus => "0000", sevSegOut => "0000001"),
  (bcdStimulus => "0001", sevSegOut => "1001111"),
  (bcdStimulus => "0010", sevSegOut => "0010010"),
  (bcdStimulus => "0011", sevSegOut => "0000110"),
  (bcdStimulus => "0100", sevSegOut => "1001100"),
  (bcdStimulus => "0101", sevSegOut => "0100100"),
  (bcdStimulus => "0110", sevSegOut => "0100000"),
  (bcdStimulus => "0111", sevSegOut => "0001111"),
  (bcdStimulus => "1000", sevSegOut => "0000000"),
  (bcdStimulus => "1001", sevSegOut => "0000100"),
  (bcdStimulus => "1010", sevSegOut => "ZZZZZZZ"),
  (bcdStimulus => "1011", sevSegOut => "ZZZZZZZ"),
  (bcdStimulus => "1100", sevSegOut => "ZZZZZZZ"),
  (bcdStimulus => "1101", sevSegOut => "ZZZZZZZ"),
  (bcdStimulus => "1110", sevSegOut => "ZZZZZZZ"),
  (bcdStimulus => "1111", sevSegOut => "ZZZZZZZ"),
  (bcdStimulus => "0000", sevSegOut => "0110110") -- this vector fails
  );

for all : sevenSegment use entity work.sevenSegment(behavioral);

signal StimInputs: std_logic_vector(3 downto 0);
signal CaptureOutputs: std_logic_vector(6 downto 0);

begin

  u1: sevenSegment port map (bcdInputs => StimInputs,
                             a_n => CaptureOutputs(6),
                             b_n => CaptureOutputs(5),
                             c_n => CaptureOutputs(4),
                             d_n => CaptureOutputs(3),
                             e_n => CaptureOutputs(2),
                             f_n => CaptureOutputs(1),
                             g_n => CaptureOutputs(0));

  LoopStim: process
    variable FoundError: boolean := false;
    variable TempVector: vector;
    variable ErrorMsgLine: line;
  begin

    for i in vectorTable'range loop
      TempVector := vectorTable(i);

      StimInputs <= TempVector.bcdStimulus;

      wait for PropDelay;

      if CaptureOutputs /= TempVector.sevSegOut then
          write (ErrorMsgLine, string'("Vector failed at "));
          write (ErrorMsgLine, now);
          writeline (output, ErrorMsgLine);
          FoundError := true;
      end if;

      wait for SimLoopDelay;

    end loop;

  assert FoundError
    report "No errors. All vectors passed."
    severity note;

  wait;

  end process;

end testbench;
