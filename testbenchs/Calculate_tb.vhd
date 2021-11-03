----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2020 08:40:25
-- Design Name: 
-- Module Name: Calculate_tb - test_bench
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

entity Calculate_tb is
--  Port ( );
end Calculate_tb;

architecture test_bench of Calculate_tb is

    signal Reg14c1out,Reg14c2out,CalcOut : STD_LOGIC_VECTOR (13 downto 0);
    signal Reg2out : STD_LOGIC_VECTOR (1 downto 0);
    signal Equal,DoneCalculating : STD_LOGIC;

begin
    
    test_bench : entity work.Calculate
    port map(Reg14c1out,Reg14c2out,Reg2out,Equal,CalcOut,DoneCalculating);
    
    clock : process is
    begin
        Equal <= '0';
        wait for 30ns;
        Equal <= '1';
        wait for 10ns;
    end process;

    signal_gen : process is
    begin
        Reg14c1out <= "00000000001001";
        wait for 10ns;
        Reg2out <= "11";
        wait for 10ns;
        Reg14c2out <= "00000000001100";
        wait for 10ns;
    end process;

end test_bench;
