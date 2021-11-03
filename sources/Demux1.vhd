----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 16:46:47
-- Design Name: 
-- Module Name: Demux1 - Behavioral
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

entity Demux1 is
    Port ( Pressed : in STD_LOGIC;      --Signal indiquant si une touche du clavié est appuyée
           DecodeOut : in STD_LOGIC_VECTOR (3 downto 0);    --Signal indiquant quelle touche est appuyée
           SelectedDisplay : in STD_LOGIC;                  --Signal indiquant ce qui est affiché sur l'afficheur 7 segment actuellement (1 : le résultat de l'opération, 0 : le chiffre que l'on est en train de saisir)
           Reg16_4in : out STD_LOGIC_VECTOR (3 downto 0);   --Signal donnant au reg16 le chiffre appuyé pour la saisie des opérandes
           PressedReg16 : out STD_LOGIC;                    --Signal indiquant au Reg16 de prendre en compte la saisie au clavier, d'ajouter le chiffre au registre
           Reg2opIn : out STD_LOGIC_VECTOR (1 downto 0);    --Signal indiquant au Reg2op quel opération a été choisi par l'utilisateur, en fonction de la touche appuyé au clavier
           PressedReg2op : out STD_LOGIC;                   --Signal indiquant au Reg2op de prendre en compte la frappe d'une opération, de sauvegarder l'opération choisie par l'utilisateur
           PressedEqual : out STD_LOGIC;                    --Signal indiquant que la touche Egal a été appuyée
           PressedClear : out STD_LOGIC                     --Signal indiquant que la touche de Reset a été appuyée
    );
end Demux1;

architecture Behavioral of Demux1 is
begin

PressedReg2op <= '1' when (DecodeOut = "1010" or DecodeOut = "1011" or DecodeOut = "1100"
                            or DecodeOut = "1101") and Pressed = '1' and selectedDisplay = '0' else '0';
PressedReg16 <= '1' when not(DecodeOut = "1010" or DecodeOut = "1011" or DecodeOut = "1100"
                        or DecodeOut = "1101" or DecodeOut = "1110" or DecodeOut = "1111") and Pressed = '1' and SelectedDisplay = '0'
                        else '0';
PressedEqual <= '1' when DecodeOut = "1110" and Pressed = '1' and selectedDisplay = '0' else '0';
PressedClear <= '1' when DecodeOut = "1111" and Pressed = '1' else '0';

with DecodeOut select           --Opérations : / = 00, x = 01, - = 10, + = 11 
Reg2opIn <= "00" when "1010",
            "01" when "1011",
            "10" when "1100",
            "11" when others;
Reg16_4in <= DecodeOut;

end Behavioral;
