----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 15:45:47
-- Design Name: 
-- Module Name: Reg16 - Behavioral
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

entity Reg16 is
    Port ( 
        Reg16_4in : in STD_LOGIC_VECTOR (3 downto 0);
        ClearReg16 : in STD_LOGIC;
        PressedReg16 : in STD_LOGIC;
        Reg16BCDout : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Reg16;

architecture Behavioral of Reg16 is
signal BCDtemp : STD_LOGIC_VECTOR(15 downto 0) :=(others => '0');
begin

    process(PressedReg16, ClearReg16)
    begin
        if ClearReg16 = '1' and PressedReg16='0' then
            BCDtemp <= (others => '0');
        elsif PressedReg16'event and PressedReg16='1' then
            BCDtemp <= BCDtemp(11 downto 0) & Reg16_4in;
        end if; 
    end process;

    Reg16BCDout <= BCDtemp;

end Behavioral;
