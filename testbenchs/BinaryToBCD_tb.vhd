----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 19:29:46
-- Design Name: 
-- Module Name: BinaryToBCD_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BinaryToBCD_tb is
end BinaryToBCD_tb;

architecture test_bench of BinaryToBCD_tb is
Signal startConvert_int : STD_LOGIC;
Signal clk_int : STD_LOGIC;
Signal CalcOut_int : STD_LOGIC_VECTOR (13 downto 0);
Signal BCDOut_int : STD_LOGIC_VECTOR (15 downto 0);
Signal DoneConverting_int : STD_LOGIC;
begin
    
    test_bench: entity work.BinaryToBCD port map(
        startConvert_int,
        clk_int,
        CalcOut_int,
        BCDOut_int,
        DoneConverting_int
    );
    
    process
    begin
        clk_int <= '0';
        wait for 10ns;
        clk_int <= '1';
        wait for 10ns;
    end process;
end test_bench;
