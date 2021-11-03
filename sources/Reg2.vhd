----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2020 18:19:56
-- Design Name: 
-- Module Name: Reg2 - Behavioral
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

entity Reg2 is
    Port ( IN_2 : in STD_LOGIC_VECTOR (1 downto 0);
           Q : in STD_LOGIC;
           OUT_2 : out STD_LOGIC_VECTOR (1 downto 0));
end Reg2;

architecture Behavioral of Reg2 is
Signal mem : STD_LOGIC_VECTOR (1 downto 0) := "00";
begin

    process(Q)
    begin
        if rising_edge(Q) then
            mem <= IN_2;    
        end if;
    end process;
    
    OUT_2 <= mem;

end Behavioral;
