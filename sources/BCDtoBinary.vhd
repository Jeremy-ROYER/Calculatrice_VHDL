----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 15:44:23
-- Design Name: 
-- Module Name: BCDtoBinary - Behavioral
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

entity BCDtoBinary is
    Port ( startConvertToBinary : in STD_LOGIC;             --Démarrer la convertion
           clk : in STD_LOGIC;                              --Signal d'horloge
           Reg16BCDout : in STD_LOGIC_VECTOR (15 downto 0); --Entrée du convertisseur en BCD
           BinaryOut : out STD_LOGIC_VECTOR (13 downto 0);  --Sortie du convertisseur en binaire
           doneConvertingToBinary : out STD_LOGIC := '0');  --Signal indiquant la fin de la convertion
end BCDtoBinary;

architecture Behavioral of BCDtoBinary is
Signal tempConvert : STD_LOGIC_VECTOR (13 downto 0) := (others=>'0'); --Signal temporaire de convertion
Signal stage : STD_LOGIC_VECTOR (1 downto 0) := "11";   --Signal indiquant l'étape de la convertion
Signal addCounter : STD_LOGIC_VECTOR (3 downto 0);      --Signal compteur pour la convertion
Signal startedConverting : STD_LOGIC := '0';            --Signal indiquant que la convertion est en cours
Signal sentDoneConverting : STD_LOGIC;                  --Signal indiquant que l'on a envoyé le signal de fin de convertion
begin

--Fonctionnement :
--Il y a 4 étape dans la convertion : 
--Etape 1 (stage 00) : On initialise le signal temporaire en le mettant à 0 sauf les 4 derniers bits qui prennent la valeur des 4 derniers bits de l'entrée en BCD (du bit 3 au bit 3)
--Etape 2 (stage 01) : On ajoute n fois 10 au signal temporaire, avec n le chiffre des dizaines (du bit 7 au bit 4 de l'entrée en BCD)
--                     (on initialise un compteur (addCounter) à 0 puis on l'incrémente à chaque fois qu'on ajoute 10, jusqu'à ce que cela corresponde au chiffre des dizaines)
--Etape 3 (stage 10) : Identique qu'à l'étape 2, sauf que l'on ajoute n fois 100, avec n le chiffre des centaines (du bit 11 au bit 8 de l'entrée en BCD)
--Etape 4 (stage 11) : Identique qu'à l'étape 2, sauf que l'on ajoute n fois 1000, avec n le chiffre des milliers (du bit 15 au bit 12 de l'entrée en BCD)

--Une fois l'étape 4 fini on met le signal temporaire en sortie et on indique que la convertion est fini
--Un coup d'horloge après la fin de l'étape 4, le signal indiquant que la convertion est fini est remis à 0 

process(clk)
begin
    if rising_edge(clk) then
        if stage="00" then
            tempConvert <= "0000000000" & Reg16BCDout(3 downto 0);
            stage <= "01";
            addCounter <= "0000";
        elsif stage="01" then
            if addCounter = Reg16BCDout(7 downto 4) then
                stage <= stage + 1;
                addCounter <= "0000";
            else
                tempConvert <= tempConvert + 10;
                addCounter <= addCounter + 1;
            end if;
        elsif stage="10" then
            if addCounter = Reg16BCDout(11 downto 8) then
                stage <= stage + 1;
                addCounter <= "0000";
            else
                tempConvert <= tempConvert + 100;
                addCounter <= addCounter + 1;
            end if;
        elsif stage="11" then
            if startConvertToBinary = '1' and startedConverting = '0' then
                startedConverting <= '1';
                tempConvert <= (others=>'0');
                doneConvertingToBinary <= '0';
                sentDoneConverting <= '0';
                stage <= "00";
            elsif addCounter = Reg16BCDout(15 downto 12) then
                if sentDoneConverting = '1' then
                    doneConvertingToBinary <= '0';
                else
                    sentDoneConverting <= '1';
                    doneConvertingToBinary <= '1';
                    BinaryOut <= tempConvert;
                end if;
            else
                tempConvert <= tempConvert + 1000;
                addCounter <= addCounter + 1;
            end if;           
        end if;
        if startConvertToBinary = '0' and startedConverting = '1' then
            startedConverting <= '0';
        end if;
    end if;
end process;

end Behavioral;