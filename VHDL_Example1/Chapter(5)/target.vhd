library IEEE;
use IEEE.std_logic_1164.all;

entity pci_target is port (
  PCI_Frame_n: in std_logic;    -- PCI Frame#
  PCI_Irdy_n: in std_logic;     -- PCI Irdy#
  Hit: in std_logic;            -- Hit on address decode
  D_Done: in std_logic;         -- Device decode complete
  Term: in std_logic;           -- Terminate transaction
  Ready: in std_logic;          -- Ready to transfer data
  Cmd_Write: in std_logic;      -- Command is Write
  Cmd_Read: in std_logic;       -- Command is Read
  T_Abort: in std_logic;        -- Target error  - abort transaction
  PCI_Clk: in std_logic;        -- PCI Clock
  PCI_Reset_n: in std_logic;    -- PCI Reset#

  PCI_Devsel_n: out std_logic;	-- PCI Devsel#
  PCI_Stop_n: out std_logic;    -- PCI Stop#
  PCI_Trdy_n: out std_logic;    -- PCI Trdy#
  OE_AD: out std_logic;         -- PCI AD bus enable
  OE_Trdy_n: out std_logic;     -- PCI Trdy# enable
  OE_Stop_n: out std_logic;     -- PCI Stop# enable
  OE_Devsel_n: out std_logic    -- PCI Devsel# enable
  );
end pci_target;

architecture fsm of pci_target is

signal LPCI_Devsel_n, LPCI_Trdy_n, LPCI_Stop_n: std_logic;

type targetFsmType is (Idle, B_Busy, Backoff, S_Data, Turn_Ar);

signal currState, nextState: targetFsmType;

begin

-- Process to generate next state logic

 nxtStProc: process (currState, PCI_Frame_n, Hit, D_Done, PCI_Irdy_n, LPCI_Trdy_n,
			         LPCI_Devsel_n, LPCI_Stop_n, Term, Ready) begin
   case currState is
     when Idle  =>
      if (PCI_Frame_n = '0' and Hit = '0') then
        nextState <= B_Busy;
      else
        nextState <= Idle;
      end if;

    when B_Busy =>
      if (PCI_Frame_n ='1' and D_Done = '1') or
	     (PCI_Frame_n = '1' and D_Done = '0' and LPCI_Devsel_n = '0') then
        nextState <= Idle;
      elsif (PCI_Frame_n = '0' or PCI_Irdy_n = '0') and Hit = '1' and
		    (Term = '0' or (Term = '1' and Ready = '1') ) then
        nextState <= S_Data;
      elsif (PCI_Frame_n = '0' or PCI_Irdy_n = '0') and Hit = '1' and
		    (Term = '1' and Ready = '0') then
        nextState <= Backoff;
      else
        nextState <= B_Busy;
      end if;

    when S_Data =>
      if PCI_Frame_n = '0' and LPCI_Stop_n = '0' and (LPCI_Trdy_n = '1' or PCI_Irdy_n = '0') then
        nextState <= Backoff;
      elsif PCI_Frame_n = '1' and (LPCI_Trdy_n = '0' or LPCI_Stop_n = '0') then
        nextState <= Turn_Ar;
      else
        nextState <= S_Data;
      end if;


    when Backoff =>
      if PCI_Frame_n = '1' then
        nextState <= Turn_Ar;
      else
        nextState <= Backoff;
      end if;

    when Turn_Ar  =>
      if (PCI_Frame_n = '0' and Hit = '0') then
        nextState <= B_Busy;
      else
        nextState <= Idle;
      end if;

    when others =>
      null;

    end case;

  end process nxtStProc;


-- Process to register the current state

  curStProc: process (PCI_Clk, PCI_Reset_n) begin
    if (PCI_Reset_n = '0') then
      currState <= Idle;
    elsif (PCI_Clk'event and PCI_Clk = '1') then
      currState <= nextState;
    end if;
  end process curStProc;


-- Process to generate outputs

  outConProc: process (currState, Ready, T_Abort, Cmd_Write,
                       Cmd_Read, T_Abort, Term) begin
    case currState is
      when S_Data =>
        if (Cmd_Read = '1') then 
          OE_AD <= '1';
        else
          OE_AD <= '0';
        end if;

        if (Ready = '1' and T_Abort = '0' and (Cmd_Write = '1' or Cmd_Read = '1')) then
          LPCI_Trdy_n <= '0';
        else
          LPCI_Trdy_n <= '1';
        end if;

        if (T_Abort = '1' or Term = '1') and (Cmd_Write = '1' or Cmd_Read = '1')  then
          LPCI_Stop_n <= '0';
        else
          LPCI_Stop_n <= '1';
        end if;

        if (T_Abort = '0') then
          LPCI_Devsel_n <= '0';
        else
          LPCI_Devsel_n <= '1';
        end if;

        OE_Trdy_n <= '1';
        OE_Stop_n <= '1';
        OE_Devsel_n <= '1';

      when Backoff =>
        if (Cmd_Read = '1') then 
          OE_AD <= '1';
        else
          OE_AD <= '0';
        end if;

        LPCI_Stop_n <= '0';

        OE_Trdy_n <= '1';
        OE_Stop_n <= '1';
        OE_Devsel_n <= '1';

        if (T_Abort = '0') then
          LPCI_Devsel_n <= '0';
        else
          LPCI_Devsel_n <= '1';
        end if;

      when Turn_Ar =>

        OE_Trdy_n <= '1';
        OE_Stop_n <= '1';
        OE_Devsel_n <= '1';

      when others =>

        OE_Trdy_n <= '0';
        OE_Stop_n <= '0';
        OE_Devsel_n <= '0';
        OE_AD <= '0';
        LPCI_Trdy_n <= '1';
        LPCI_Stop_n <= '1';
        LPCI_Devsel_n <= '1';

    end case;

  end process outConProc;

-- Assign output ports

  PCI_Devsel_n <= LPCI_Devsel_n;
  PCI_Trdy_n <= LPCI_Trdy_n;
  PCI_Stop_n <= LPCI_Stop_n;

end fsm;
