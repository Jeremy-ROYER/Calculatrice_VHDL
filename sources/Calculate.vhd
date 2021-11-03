----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2020 14:59:11
-- Design Name: 
-- Module Name: Calculate - Behavioral
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

entity Calculate is
    Port ( Reg14c1out : in STD_LOGIC_VECTOR (13 downto 0);
           Reg14c2out : in STD_LOGIC_VECTOR (13 downto 0);
           Reg2opOut : in STD_LOGIC_VECTOR (1 downto 0);
           PressedEqual : in STD_LOGIC;
           clk : in STD_LOGIC;
           CalcOut : out STD_LOGIC_VECTOR (13 downto 0);
           DoneCalculating : out STD_LOGIC := '0';
           ErrorCalc : out STD_LOGIC := '0'
    );
end Calculate;

architecture Structural of Calculate is
    signal ADDtemp : std_logic_vector(13 downto 0);
    signal waitTemp : std_logic_vector(2 downto 0) := "111";
    signal sentDoneCalculating : STD_logic := '0';
    Signal error_add : STD_LOGIC := '0';
begin
    --Addition
    ADD_14 : entity work.ADD_14
    port map (a => Reg14c1out, b => Reg14c2out, Cin => '0', s => ADDtemp, Cout => error_add);

	--Multiplication
	--/!\ Nous avons seulement eu le temps de commencer la multiplication mais pas le temps de la faire fonctionner
	--/!\ L'entity Mult_14 est donc dans les fichiers sources mais n'est pas implémentée dans Calculate (car non fonctionnelle pour le moment)

    process(clk)
    begin
        if rising_edge(clk) then
            if waitTemp /="111" then
                waitTemp <= waitTemp + 1;
            elsif PressedEqual = '1' then
                waitTemp <= (others => '0');
            end if;
        end if;
    end process;

DoneCalculating <= '1' when Reg2opOut = "11" and waitTemp = "110" else '0';
CalcOut <= Addtemp when Reg2opOut = "11";
ErrorCalc <= '1' when Reg2opOut = "11" and waitTemp = "110" and (error_add = '1' or ADDtemp > "10011100001111") else '0';

        
end Structural;