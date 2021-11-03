----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 23:23:29
-- Design Name: 
-- Module Name: Decodeur_7_seg - Behavioral
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

entity Decodeur_7_seg is
    Port(   IN_4 : in std_logic_vector(3 downto 0);
            OUT_7 : out std_logic_vector(6 downto 0));
end Decodeur_7_seg;

architecture Behavioral of Decodeur_7_seg is
begin
With IN_4 select
    OUT_7 <= "1000000" when "0000", --0
                "1111001" when "0001", --1
                "0100100" when "0010", --2
                "0110000" when "0011", --3
                "0011001" when "0100", --4
                "0010010" when "0101", --5
                "0000010" when "0110", --6
                "1111000" when "0111", --7
                "0000000" when "1000", --8
                "0010000" when "1001", --9
                "0001000" when "1010", --A
                "0000011" when "1011", --B
                "1000110" when "1100", --C
                "0100001" when "1101", --D
                "0000110" when "1110", --E
                "0001110" when "1111", --F
                "1111111" when others; 
end Behavioral;
