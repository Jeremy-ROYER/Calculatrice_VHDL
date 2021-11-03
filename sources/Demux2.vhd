----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2020 17:28:54
-- Design Name: 
-- Module Name: Demux2 - Behavioral
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

entity Demux2 is
    Port ( BinaryOut : in STD_LOGIC_VECTOR (13 downto 0);   --Signal en sortie du convertisseur binaire
           doneConvertingToBinary : in STD_LOGIC;           --Signal indiquant que la convertion en binaire est terminée
           PressedReg2op : in STD_LOGIC;                    --Signal indiquant qu'une touche d'opération est appuyée
           PressedEqual : in STD_LOGIC;                     --Signal indiquant que la touche égal est appuyée 
           Reg14c1clk : out STD_LOGIC;                      --Signal indiquant au Reg14c1 d'enregistrer le nombre binaire
           Reg14c1in : out STD_LOGIC_VECTOR (13 downto 0);  --Signal binaire en entrée du Reg14c1
           Reg14c2clk : out STD_LOGIC;                      --Signal indiquant au Reg14c2 d'enregistrer le nombre binaire
           Reg14c2in : out STD_LOGIC_VECTOR (13 downto 0)); --Signal binaire en entrée du Reg14c2
end Demux2;

architecture Behavioral of Demux2 is
begin

--Si l'on reçoit le signal de fin de convertion et qu'une touche d'opération est appuyée
--Alors c'est que l'on a saisi la première opérande, on l'enregistre dans Reg14c1
--Sinon, si l'on reçcoit le signal de fin de convertion et que la touche égal est appuyée
--C'est que l'on a saisi la deuxième opérande, on l'enregsitre dans Reg14c2

Reg14c1in <= BinaryOut;
Reg14c2in <= BinaryOut;
Reg14c1clk <= '1' when PressedReg2op = '1' and doneConvertingToBinary = '1' else '0';
Reg14c2clk <= '1' when PressedEqual = '1' and doneConvertingToBinary = '1' else '0';

end Behavioral;
