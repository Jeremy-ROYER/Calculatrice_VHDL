----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 23:09:21
-- Design Name: 
-- Module Name: Afficheur_7_seg - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Afficheur_7_seg is
    Port ( BCDin : in STD_LOGIC_VECTOR (15 downto 0);   --Signal en BCD a afficher
           clk : in STD_LOGIC;  --Signal d'horloge
           Error : in STD_LOGIC;    --Signal indiquant qu'il y a eu une erreur lors de la convertion
           Sept_Seg : out STD_LOGIC_VECTOR (6 downto 0);    --Signal de controle individuel de l'afficheur
           An : out STD_LOGIC_VECTOR (3 downto 0));         --Signal indiquant quel afficheur controler 
end Afficheur_7_seg;

architecture Behavioral of Afficheur_7_seg is
Signal sclk : STD_LOGIC_VECTOR (19 downto 0):=(others=>'0');    --Signal compteur du temps d'affichage
Signal NumToDisplay : STD_LOGIC_VECTOR(3 downto 0);             --Signal indiquant le chiffre à afficher en BCD
Signal Sept_Seg_int1 : STD_LOGIC_VECTOR(6 downto 0);
Signal Sept_Seg_int2 : STD_LOGIC_VECTOR(6 downto 0);
begin

Decodeur_7_seg: entity work.Decodeur_7_seg port map(    --Décodeur permettant la convertion du chiffre en BCD en son équivalent sur l'afficheur 7 segment 
    IN_4 => NumToDisplay,
    OUT_7 => Sept_Seg_int1
);

with Error select
Sept_Seg <= Sept_Seg_int1 when '0',
            Sept_Seg_int2 when others;

--On affiche chaque chiffre pendant un court temps puis on passe au suivant
    process(clk)
    begin
    if (clk='1' and clk'event) then
        if sclk = "00000000000000000000" then
            NumToDisplay <= BCDin(15 downto 12);
            Sept_Seg_int2 <= "0000110";
            An <= "0111";
            sclk <= sclk + 1;
        elsif sclk = "111101000010010000" then --10M
            NumToDisplay <= BCDin(11 downto 8);
            Sept_Seg_int2 <= "0101111";
            An <= "1011";
            sclk <= sclk + 1;
        elsif sclk = "1111010000100100000" then --20M
            NumToDisplay <= BCDin(7 downto 4);
            Sept_Seg_int2 <= "0101111";
            An <= "1101";
            sclk <= sclk + 1;
        elsif sclk = "10110111000110110000" then --30M
            NumToDisplay <= BCDin(3 downto 0);
            Sept_Seg_int2 <= "1111111";
            An <= "1110";
            sclk <= sclk + 1;
        elsif sclk = "11110100001001000000" then --40M
            sclk <= (others=>'0');
        else
            sclk <= sclk + 1;
        end if;
    end if;
    end process;

end Behavioral;
