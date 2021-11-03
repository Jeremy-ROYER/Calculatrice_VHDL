----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2020 09:30:26
-- Design Name: 
-- Module Name: ADD_4 - Behavioral
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

entity ADD_14 is
    port(
        a, b : in std_logic_vector (13 downto 0);
        Cin : in std_logic;
        s : out std_logic_vector (13 downto 0);
        Cout : out std_logic := '0'
    );
end ADD_14;

architecture Structural of ADD_14 is
    signal c : std_logic_vector(14 downto 0);
begin

    c(0) <= Cin;
    Cout <= c(14);
    
    instance : for i in 0 to 13 generate
        ADD_1_i : entity work.add_1(Behavioral)
        port map (a => a(i), b => b(i), Cin => c(i), s => s(i), Cout =>c (i+1));
    end generate;

end Structural;
