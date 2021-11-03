----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2020 17:01:03
-- Design Name: 
-- Module Name: Reg14 - Behavioral
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

entity Reg14 is
    Port ( IN_14 : in STD_LOGIC_VECTOR (13 downto 0);
           Q : in STD_LOGIC;
           OUT_14 : out STD_LOGIC_VECTOR (13downto 0));
end Reg14;

architecture Behavioral of Reg14 is
Signal mem : STD_LOGIC_VECTOR (13 downto 0) := (others=>'0');
begin

    process(Q)
    begin
        if rising_edge(Q) then
            mem <= IN_14;    
        end if;
    end process;
    
    OUT_14 <= mem;

end Behavioral;
