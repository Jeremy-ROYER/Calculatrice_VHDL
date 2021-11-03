----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2020 09:39:23
-- Design Name: 
-- Module Name: ADD_1 - Behavioral
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

entity ADD_1 is
    port(
        a, b, Cin : in std_logic;
        s, Cout : out std_logic
    );
end ADD_1;

architecture Behavioral of ADD_1 is

begin
    
    s <= a xor b xor Cin;
    
    Cout <= (a and b) or (a and Cin) or (b and Cin);

end Behavioral;
