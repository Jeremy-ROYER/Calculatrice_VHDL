----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2020 18:33:50
-- Design Name: 
-- Module Name: Mux1 - Behavioral
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

entity Mux1 is
    Port ( PressedClear : in STD_LOGIC; --Signal indiquant que la touche de Reset a été appuyée
           DoneConvertingToBCD : in STD_LOGIC;  --Signal indiquant que la convertion de binaire en BCD est terminée
           Reg16BCDout : in STD_LOGIC_VECTOR (15 downto 0); --Signal de sortie du Reg16 en BCD
           BCDOut : in STD_LOGIC_VECTOR (15 downto 0);  --Signal de sortie du convertisseur binaire en BCD
           display : out STD_LOGIC_VECTOR (15 downto 0);    --Signal BCD à afficher sur l'afficheur 7 segment
           selectedDisplay : out STD_LOGIC);    --Signal indiquant ce qui est affiché sur l'afficheur 7 segment actuellement (1 : le résultat de l'opération, 0 : le chiffre que l'on est en train de saisir)
end Mux1;

architecture Behavioral of Mux1 is
Signal sel : STD_LOGIC := '0';
begin
    
    --Si la convertion est fini, alors on affiche le résultat sur l'afficheur
    --Sinon, si la touche de reset est appuyée, on affiche le Reg16
    process(PressedClear, DoneConvertingToBCD)
    begin
        if DoneConvertingToBCD = '1' then
            sel <= '1';
        elsif PressedClear = '1' then
            sel <= '0';
        end if;
    end process;

with sel select
display <=  Reg16BCDout when '0',
            BCDOut when others;
selectedDisplay <= sel;
end Behavioral;
