----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2021 11:30:37
-- Design Name: 
-- Module Name: MULT_14_tb - test_bench
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

entity MULT_14_tb is
--  Port ( );
end MULT_14_tb;

architecture test_bench of MULT_14_tb is

    signal c1, c2, res : std_logic_vector(13 downto 0);
    signal clk,start,done : std_logic;

begin

    test_bench : entity work.MULT_14(Structural)
    port map(c1,c2,clk,start,res,done);
    
    signal_gen : process is
    begin
        c1 <= "00000000001010";
        c2 <= "00000000000010";
        wait for 10ns;
    end process;
    
    clock : process is
    begin
        clk <= '1';
        wait for 5ns;
        clk <= '0';
        wait for 5ns;
    end process;

end test_bench;
