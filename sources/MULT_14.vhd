----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2021 10:27:59
-- Design Name: 
-- Module Name: MULT_14 - Structural
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
--use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--/!\ La multiplication n'est pas encore prête, nous n'avons pas eu le temps de la faire fonctionner,
--/!\ Elle n'est donc pas implémentée dans l'entity Calculate
entity MULT_14 is
    Port ( A : in STD_LOGIC_VECTOR (13 downto 0);
           B : in STD_LOGIC_VECTOR (13 downto 0);
           Clk : in STD_LOGIC;
           StartCalcul : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (13 downto 0);
           DoneCalculating : out STD_LOGIC);
end MULT_14;

architecture Structural of MULT_14 is

    signal Compt : std_logic_vector(3 downto 0) := (others =>'0');
    signal MultTemp : std_logic_vector(13 downto 0) := (others => '0');
    signal Zero : std_logic_vector(13 downto 0) := (others => '0');
    signal int : integer := 0;
    signal Demarrage, SentDoneCalculating, Doneintern : std_logic := '0';

begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if StartCalcul = '1' then
                Compt <= "0000";
                int <= 0;
                Doneintern <= '0';
                SentDoneCalculating <= '0';
                Demarrage <= '1';
--                if B(0) = '1' then
--                    MultTemp <= A;
--                else
--                    MultTemp <= Zero;
--                end if;
            elsif Demarrage = '1' then
                if Compt < "1101" then
                    if B(int) = '1' then
                        MultTemp <= MultTemp + ( A((13-int) downto 0) & Zero(int-1 downto 0)) ;
                    end if;
                    Compt <= Compt + 1;
                    int <= int + 1;
                elsif Doneintern = '0' and SentDoneCalculating = '0' then
                    Doneintern <= '1';
                    SentDoneCalculating <= '1';
                elsif SentDoneCalculating = '1' then
                    Doneintern <= '0';
                end if;
            end if;
        end if;
    
    end process;
    
    DoneCalculating <= Doneintern;
    S <= MultTemp;

end Structural;
