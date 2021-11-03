----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 17:59:56
-- Design Name: 
-- Module Name: BinaryToBCD - Behavioral
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

entity BinaryToBCD is
    Port ( startConvert : in STD_LOGIC; --Signal indiquant le début de la convertion
           clk : in STD_LOGIC;          --Signal d'horloge
           CalcOut : in STD_LOGIC_VECTOR (13 downto 0); --Signal en binaire en entrée (résultat du calcul)
           BCDOut : out STD_LOGIC_VECTOR (15 downto 0); --Signal converti en BCD
           DoneConvertingToBCD : out STD_LOGIC:='0');   --Signal indiquant que la convertion est finie
end BinaryToBCD;

architecture Behavioral of BinaryToBCD is
Signal tempConv : STD_LOGIC_VECTOR (29 downto 0);   --Signal temporaire de convertion
Signal compt : STD_LOGIC_VECTOR (3 downto 0);       --Signal compteur
Signal forceShift : STD_LOGIC := '0';               --Signal indiquand qu'il faut forcer le décalage du signal temporaire
Signal startedConverting : STD_LOGIC := '0';        --Signal indiquant que la convertion a commencé
Signal sentDoneConverting : STD_LOGIC := '0';       --Signal indiquant que le signal de fin de convertion a été envoyé

--Fonctionnement:
--Convertisseur basé sur l'algorithme "Double dabble"
--Voir : https://fr.wikipedia.org/wiki/Double_dabble
 
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if startConvert = '1' and startedConverting = '0' then
                startedConverting <= '1';
                tempConv <= "000000000000000" & CalcOut & "0";
                compt <= "0000";
                DoneConvertingToBCD <= '0';
                sentDoneConverting <= '0';
            elsif compt = "1101" then
                if sentDoneConverting = '1' then
                    DoneConvertingToBCD <= '0';
                else
                    startedConverting <= '0';
                    sentDoneConverting <= '1';
                    DoneConvertingToBCD <= '1';
                    BCDOut <=tempConv(29 downto 14);
                end if;
            elsif forceShift = '1' then
                tempConv <= tempConv(28 downto 0) & "0";
                forceShift <= '0';
                compt <= compt + 1;
            elsif startedConverting = '1' then
                if tempConv(17 downto 14) >= 5 then
                    tempConv(17 downto 14) <= tempConv(17 downto 14) + 3;
                    forceShift <= '1';
                end if;
                if tempConv(21 downto 18) >= 5 then
                    tempConv(21 downto 18) <= tempConv(21 downto 18) + 3;
                    forceShift <= '1';
                end if;
                if tempConv(25 downto 22) >= 5 then
                    tempConv(25 downto 22) <= tempConv(25 downto 22) +3;
                    forceShift <= '1';
                end if;
                if tempConv(29 downto 26) >= 5 then
                    tempConv(29 downto 26) <= tempConv(29 downto 26) + 3;
                    forceShift <= '1';
                end if;
                if tempConv(17 downto 14) < 5 and tempConv(21 downto 18) < 5 and tempConv(25 downto 22) < 5 and tempConv(29 downto 26) < 5 then
                    tempConv <= tempConv(28 downto 0) & "0";
                    compt <= compt + 1;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
