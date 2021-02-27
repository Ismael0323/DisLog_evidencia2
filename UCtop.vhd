----------------------------------------------------------------------------------
-- Company:        ITESM - Campus Qro.
-- Engineer:       RickWare
-- 
-- Create Date:    13:36:34 02/22/2021 
-- Design Name: 
-- Module Name:    Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:    Tail light signal and hazard control as a sequence
--                 See video: https://www.youtube.com/watch?v=jIjY7mERBrw
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

entity UCtop is
    Port ( Clk    : in  STD_LOGIC;
			  --boton  : in  STD_LOGIC;
           Rst    : in  STD_LOGIC;
			  Dato   : in  STD_LOGIC;
			  Pulso  : out STD_LOGIC_VECTOR (5 downto 0));
			  
end UCTop;

architecture Behavioral of UCTop is

  -- Component Declarations
  component FreqDiv
  port (
     Clk   : in  STD_LOGIC;
	  Rst   : in  STD_LOGIC;
	  ClkEn : out STD_LOGIC);
  end component;
  
  component UnidadC
  port (
	  Clk   : in  STD_LOGIC;
	  Rst   : in  STD_LOGIC;
	  ClkEn : in  STD_LOGIC;
	  Dato  : in  STD_LOGIC;
	  Pulso : out STD_LOGIC_VECTOR (5 downto 0));
	end component;
	
	-- Embedded Signals
	signal ClkEn_emb : STD_LOGIC;
  
begin
  -- Component Instantiation
  U1 : FreqDiv
  port map (
     Clk   => Clk,
	  Rst   => Rst,
	  ClkEn => ClkEn_emb);
	  
	U2 : UnidadC
	port map (
	  Clk   => Clk,
	  Rst   => Rst,
	  ClkEn => ClkEn_emb,
	  Dato  => Dato,
	  Pulso => Pulso);
		
		
end Behavioral;

