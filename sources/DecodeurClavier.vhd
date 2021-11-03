----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 15:36:35
-- Design Name: 
-- Module Name: DecodeurClavier - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DecodeurClavier is
Port (  clk : in  STD_LOGIC;
        Row : in  STD_LOGIC_VECTOR (3 downto 0);
        Col : out  STD_LOGIC_VECTOR (3 downto 0);
        DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0) := "0000";
        Pressed : out STD_LOGIC := '0');
end DecodeurClavier;

architecture Behavioral of DecodeurClavier is
signal sclk :STD_LOGIC_VECTOR(19 downto 0) := "00011000011010100000";
signal pressedC1, pressedC2, pressedC3, pressedC4 : STD_LOGIC; --Signal à 1 lorsque la colonne correspondante est appuyé, 0 sinon
begin

Pressed <= pressedC1 or pressedC2 or pressedC3 or pressedC4; --Signal à 1 lorsqu'au moins une colonne est appuyée
	process(clk)
		begin 
		if clk'event and clk = '1' then
			-- 1ms
			if sclk = "00011000011010100000" then 
				--C1
				Col<= "0111";
				sclk <= sclk+1;
			-- check row pins
			elsif sclk = "00011000011010101000" then	
				--R1
				if Row = "0111" then
					DecodeOut <= "0001";	--1
					pressedC1<='1';
				--R2
				elsif Row = "1011" then
					DecodeOut <= "0100"; --4
					pressedC1<='1';
				--R3
				elsif Row = "1101" then
					DecodeOut <= "0111"; --7
					pressedC1<='1';
				--R4
				elsif Row = "1110" then
					DecodeOut <= "0000"; --0
					pressedC1<='1';
				else
				    pressedC1<='0';
				end if;
				sclk <= sclk+1;
			-- 2ms
			elsif sclk = "00110000110101000000" then	
				--C2
				Col<= "1011";
				sclk <= sclk+1;
			-- check row pins
			elsif sclk = "00110000110101001000" then	
				--R1
				if Row = "0111" then		
					DecodeOut <= "0010"; --2
					pressedC2<='1';
				--R2
				elsif Row = "1011" then
					DecodeOut <= "0101"; --5
					pressedC2<='1';
				--R3
				elsif Row = "1101" then
					DecodeOut <= "1000"; --8
					pressedC2<='1';
				--R4
				elsif Row = "1110" then
					DecodeOut <= "1111"; --F
					pressedC2<='1';
				else
				    pressedC2<='0';
				end if;
				sclk <= sclk+1;	
			--3ms
			elsif sclk = "01001001001111100000" then 
				--C3
				Col<= "1101";
				sclk <= sclk+1;
			-- check row pins
			elsif sclk = "01001001001111101000" then 
				--R1
				if Row = "0111" then
					DecodeOut <= "0011"; --3
					pressedC3<='1';	
				--R2
				elsif Row = "1011" then
					DecodeOut <= "0110"; --6
					pressedC3<='1';
				--R3
				elsif Row = "1101" then
					DecodeOut <= "1001"; --9
					pressedC3<='1';
				--R4
				elsif Row = "1110" then
					DecodeOut <= "1110"; --E
					pressedC3<='1';
                else
                    pressedC3<='0';
				end if;
				sclk <= sclk+1;
			--4ms
			elsif sclk = "01100001101010000000" then 			
				--C4
				Col<= "1110";
				sclk <= sclk+1;
			-- check row pins
			elsif sclk = "01100001101010001000" then 
				--R1
				if Row = "0111" then
					DecodeOut <= "1010"; --A
					pressedC4<='1';
				--R2
				elsif Row = "1011" then
					DecodeOut <= "1011"; --B
					pressedC4<='1';
				--R3
				elsif Row = "1101" then
					DecodeOut <= "1100"; --C
					pressedC4<='1';
				--R4
				elsif Row = "1110" then
					DecodeOut <= "1101"; --D
					pressedC4<='1';
                else
                    pressedC4<='0';                
				end if;
				sclk <= "00000000000000000000";	
			else
				sclk <= sclk+1;	
			end if;
		end if;
	end process;
end Behavioral;
