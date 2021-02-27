----------------------------------------------------------------------------------
-- Company:        ITESM - Campus Qro.
-- Engineer:       Ismael García González
-- 
-- Create Date:    13:36:34 02/26/2021 
-- Design Name: 
-- Module Name:    UnidadC
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:    Unit control instruction
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity UnidadC is
  port (
	  Clk   : in  STD_LOGIC;
	  Rst   : in  STD_LOGIC;
	  ClkEn : in  STD_LOGIC;
	  Dato  : in  STD_LOGIC;
	  Puls  : out STD_LOGIC_VECTOR (5 downto 0));
end UnidadC;

architecture arq of UnidadC is
  -- State name declaration as binary state
  -- User defined type as an enumeration list giving the State names
  
  -- (Initial State, memory pulse, Instruction Register,
  -- Data Register, Temporal ACUM, Permanent ACUM, Program Counter)
  
  type state_values is (Ini, memo, IR, memo2, DR, TA, PA, PC); --
  
  signal pres_state: state_values;
  signal next_state: state_values;
  -- signal band : integer; -- bandera
  
begin

  ----------State Register definition process.-----------
  -- Is Sequential based of D-type FFs
  statereg: process(Clk,Rst)
  begin
    if (Rst = '0') then
	   pres_state <= Ini;
	 elsif rising_edge(Clk) then
	   if (ClkEn = '1') then
		  pres_state <= next_state;
		end if;
	 end if;
  end process statereg;
  
  ----------- Next State Logic definition.----------------
  -- This is a combinatorial process
  -- Put in statements the State Diagram
  fsm: process(Dato, pres_state)
  begin
  -- band := 0;
  
  ------working------------------------------------
  If (dato = '1') then
		case (pres_state) is
			when Ini => next_state <= memo;
			when memo => next_state <= IR;
			when IR => next_state <= memo2;
			when memo2 => next_state <= DR;
			when DR => next_state <= TA;
			when TA => next_state <= PA;
			when PA => next_state <= memo;
			when others => next_state <= Ini;	
		end case;
	 else
		case (pres_state) is
			when Ini => next_state <= memo;
			when memo => next_state <= IR;
			when IR => next_state <= TA;
			when TA => next_state <= PA;
			when others => next_state <= Ini;
		end case;
	end if;
  
 
  end process fsm;
 
  -- Output Logic Definitions of a Moore State MAchine.
  -- Outputs depend only on the current state
  -- This is a combinatorial process
  outputs: process(pres_state)
  begin
    case pres_state is 
	   when Ini		=> Puls <= "000000";
	   when memo  	=> Puls <= "100000";
	   when IR   	=> Puls <= "010001"; --with PC
		when memo2 	=> Puls <= "100000";
	   when DR   	=> Puls <= "001001"; --w PC
	   when TA   	=> Puls <= "000100";
	   when PA  	=> Puls <= "000010";
      when others =>	Puls <= "000000";
	end case;
    
  end process outputs;
  
  
end arq;