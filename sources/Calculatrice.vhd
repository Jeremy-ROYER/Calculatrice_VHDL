----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2020 23:05:31
-- Design Name: 
-- Module Name: Calculatrice - Behavioral
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

entity Calculatrice is
    Port (  clk : in STD_LOGIC;
            Row : in STD_LOGIC_VECTOR (3 downto 0);
            Col : out STD_LOGIC_VECTOR (3 downto 0);
            Sept_Seg : out STD_LOGIC_VECTOR (6 downto 0);
            An : out STD_LOGIC_VECTOR (3 downto 0));
end Calculatrice;

architecture Behavioral of Calculatrice is
Signal DecodeOut : STD_LOGIC_VECTOR (3 downto 0);
Signal Pressed : STD_LOGIC;
Signal PressedReg2op : STD_LOGIC;
Signal PressedEqual : STD_LOGIC;
Signal PressedReg16 : STD_LOGIC;
Signal PressedClear : STD_LOGIC;

Signal Reg16_4in : STD_LOGIC_VECTOR (3 downto 0);
Signal Reg16BCDout : STD_LOGIC_VECTOR(15 downto 0);
Signal ClearReg16 : STD_LOGIC;

Signal Reg2opIn : STD_LOGIC_VECTOR (1 downto 0);
Signal Reg2opOut : STD_LOGIC_VECTOR (1 downto 0);

Signal startConvertToBinary : STD_LOGIC;
Signal BinaryOut : STD_LOGIC_VECTOR(13 downto 0);
Signal doneConvertingToBinary : STD_LOGIC;

Signal Reg14c1clk : STD_LOGIC;
Signal Reg14c1in : STD_LOGIC_VECTOR(13 downto 0);
Signal Reg14c1out : STD_LOGIC_VECTOR(13 downto 0);
Signal Reg14c2clk : STD_LOGIC;
Signal Reg14c2in : STD_LOGIC_VECTOR(13 downto 0);
Signal Reg14c2out : STD_LOGIC_VECTOR(13 downto 0);

Signal CalcOut : STD_LOGIC_VECTOR(13 downto 0);
Signal DoneCalculating : STD_LOGIC;
Signal ErrorCalc : STD_LOGIC;

Signal BCDOut : STD_LOGIC_VECTOR(15 downto 0);
Signal doneConvertingToBCD : STD_LOGIC;

Signal display : STD_LOGIC_VECTOR(15 downto 0) := (others=>'0');
Signal selectedDisplay : STD_LOGIC;

Signal temp : STD_LOGIC := '0';
Signal Error : STD_LOGIC := '0';
begin
DecodeurClavier: entity work.DecodeurClavier port map(
    clk => clk,
    Row => Row,
    Col => Col,
    DecodeOut => DecodeOut,
    Pressed => Pressed
);

Demux1: entity work.Demux1 port map(
    Pressed => Pressed,
    DecodeOut => DecodeOut,
    selectedDisplay => selectedDisplay,
    Reg16_4in => Reg16_4in,
    PressedReg16 => PressedReg16,
    Reg2opIn => Reg2opIn,
    PressedReg2op => PressedReg2op,
    PressedEqual => PressedEqual,
    PressedClear => PressedClear
);

Reg2 : entity work.Reg2 port map(
    IN_2 => Reg2opIn,
    Q => PressedReg2op,
    OUT_2 => Reg2opOut
);

startConvertToBinary <= PressedReg2op or PressedEqual;
ClearReg16 <= PressedClear or doneConvertingToBinary;

Reg16: entity work.Reg16 port map(
    Reg16_4in => Reg16_4in,
    ClearReg16 => ClearReg16,
    PressedReg16 => PressedReg16,
    Reg16BCDout => Reg16BCDout
);

BCDToBinary : entity work.BCDToBinary port map(
    startConvertToBinary => startConvertToBinary,
    clk => clk,
    Reg16BCDout => Reg16BCDout,
    BinaryOut => BinaryOut,
    doneConvertingToBinary => doneConvertingToBinary
);

Demux2 : entity work.Demux2 port map(
    BinaryOut => BinaryOut,
    doneConvertingToBinary => doneConvertingToBinary,
    PressedReg2op => PressedReg2op,
    PressedEqual => PressedEqual,
    Reg14c1clk => Reg14c1clk,
    Reg14c1in => Reg14c1in,
    Reg14c2clk => Reg14c2clk,
    Reg14c2in => Reg14c2in
);

Reg14c1 : entity work.Reg14 port map(
    IN_14 => Reg14c1in,
    Q => Reg14c1clk,
    OUT_14 => Reg14c1out
);

Reg14c2 : entity work.Reg14 port map(
    IN_14 => Reg14c2in,
    Q => Reg14c2clk,
    OUT_14 => Reg14c2out
);

Calculate : entity work.Calculate port map(
    Reg14c1out => Reg14c1out,
    Reg14c2out => Reg14c2out,
    Reg2opOut => Reg2opOut,
    PressedEqual => PressedEqual,
    clk => clk,
    CalcOut => CalcOut,
    DoneCalculating => DoneCalculating,
    ErrorCalc => ErrorCalc
);

BinaryToBCD : entity work.BinaryToBCD port map(
    startConvert => DoneCalculating,
    clk => clk,
    CalcOut =>CalcOut,
    BCDOut => BCDOut,
    DoneConvertingToBCD => DoneConvertingToBCD
);

Mux1 : entity work.Mux1 port map(
    PressedClear => PressedClear,
    DoneConvertingToBCD => DoneConvertingToBCD,
    Reg16BCDout => Reg16BCDout,
    BCDOut => BCDOut,
    display => display,
    selectedDisplay => selectedDisplay
);

Afficheur_7_seg: entity work.Afficheur_7_seg port map(
    BCDin => display,
    clk => clk,
    Error => Error,
    Sept_Seg => Sept_Seg,
    An => An
);

Error <= '1' when ErrorCalc = '1' else
         '0' when PressedClear = '1';

--Pas faire attention pour débugger : 

--led(1) <= '1' when PressedClear = '1';
--led(2) <= PressedReg2op;
--led(3) <= PressedEqual;
--led(4) <= '1' when startConvertToBinary = '1' else '0' when PressedClear = '1';
--led(5) <= '1' when doneConvertingToBinary = '1' else '0' when PressedClear = '1';
--led(6) <= '1' when DoneCalculating = '1' else '0' when PressedClear = '1';
--led(8) <= Reg2opOut(0);
--led(9) <= Reg2opOut(1);
--led(13 downto 0) <= CalcOut;
--led(14) <= '1' when DoneCalculating = '1' else '0' when PressedClear = '1';
--led(15) <= '1' when DoneConvertingToBCD = '1' else '0' when PressedClear = '1';
--led(3 downto 0) <= BinaryOut(3 downto 0);
--led(3 downto 0) <= Reg14c1out(3 downto 0);
--led(7 downto 4) <= Reg14c2out(3 downto 0);
--led(11 downto 8) <= CalcOut(3 downto 0);
--led(15 downto 12) <= BCDout(3 downto 0);
--led(8) <= Reg14c1clk;
--led(9) <= doneConvertingToBinary;
--led(10) <= PressedReg2op;
--led(11) <= PressedEqual;
--led(12) <= PressedReg16;
--led(13) <= ClearReg16;
--led(15 downto 0) <= BCDOut;

end Behavioral;
