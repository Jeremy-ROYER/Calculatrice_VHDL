----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 18:03:23
-- Design Name: 
-- Module Name: Demux1_tb - test_bench
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

entity Demux1_tb is
--  Port ( );
end Demux1_tb;

architecture test_bench of Demux1_tb is

    signal Pressed : STD_LOGIC;
    signal DecodeOut : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg16_4in : STD_LOGIC_VECTOR (3 downto 0);
    signal PressedReg16 : STD_LOGIC;
    signal Reg2op : STD_LOGIC_VECTOR (1 downto 0);
    signal PressedReg2op : STD_LOGIC;
    signal Equal : STD_LOGIC;

begin

    test_bench : entity work.Demux1
    port map(Pressed,DecodeOut,Reg16_4in,PressedReg16,Reg2op,PressedReg2op,Equal);
    
    clock : process is
    begin
        Pressed <= '1';
        wait for 2ns;
        Pressed <= '0';
        wait for 3ns;
    end process;
    
    signal_gen : process is
    begin
        DecodeOut <= "0001"; --1
        wait for 5ns;
        DecodeOut <= "0101"; --5
        wait for 5ns;
        DecodeOut <= "1101"; -- +
        wait for 5ns;
        DecodeOut <= "0010"; --2
        wait for 5ns;
        DecodeOut <= "0011"; --3
        wait for 5ns;
        DecodeOut <= "1110";
        wait for 5ns;
    end process;

end test_bench;
