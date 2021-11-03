----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 16:24:43
-- Design Name: 
-- Module Name: Reg16_tb - test_bench
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

entity Reg16_tb is
--  Port ( );
end Reg16_tb;

architecture test_bench of Reg16_tb is

    signal Reg16_4in : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg16BCDout : STD_LOGIC_VECTOR (15 downto 0);
    signal PressedReg16 : STD_LOGIC;

begin
    test_bench : entity work.Reg16(Behavioral)
    port map(Reg16_4in,PressedReg16,Reg16BCDout);
    
    clock : process is
    begin
        PressedReg16 <= '1';
        wait for 5ns;
        PressedReg16 <= '0';
        wait for 10ns;
    end process;
    
    signal_gen : process is
    begin
        Reg16_4in <= "0001"; --1
        wait for 10ns;
        Reg16_4in <= "0101"; --5
        wait for 10ns;
    end process;

end test_bench;
