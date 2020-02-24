library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.all;

entity top_module is
    Port ( CLOCK                : in STD_LOGIC;
           FrequencyInputVector : in STD_LOGIC_VECTOR  (1 downto 0); --8 modes of selection for the period
           NoteInputVector      : in STD_LOGIC_VECTOR  (4 downto 0); --"00000" = 0, "00001" = 1, "00010" = 2, "00100" = 3, "01000" = 4 in notes, "10000" = reset
           H_SYNC               : out STD_LOGIC;
           V_SYNC               : out STD_LOGIC;
           Sound_Actual_Top     : out STD_LOGIC;
           VGA_R                : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_G                : out STD_LOGIC_VECTOR (3 downto 0);
           VGA_B                : out STD_LOGIC_VECTOR (3 downto 0);
           Display_Select       : out STD_LOGIC_VECTOR (3 downto 0);
           Segment_Select       : out STD_LOGIC_VECTOR (6 downto 0);
           TestVector           : out STD_LOGIC_VECTOR (3 downto 0)  --Just for test
           );
end top_module;

architecture Behavioral of top_module is

--Variables and Signals
SIGNAL Score         : integer;
SIGNAL Iteration     : integer;
SIGNAL PRandomNum    : integer;
SIGNAL Period        : integer;
SIGNAL Note_P        : integer;
SIGNAL VGA_R1, VGA_G1, VGA_B1 : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL Sound_Actual_Top_Sig   : STD_LOGIC;

component clock_iteration_counter
    Port ( CLK              : in STD_LOGIC;
           GamePeriod       : in integer;
           PRandomNumber    : out integer;
           IterationCounter : out integer
    );
end component;
component display_function
    PORT(
        CLK        : in STD_LOGIC;
        HSYNC      : out STD_LOGIC;
        VSYNC      : out STD_LOGIC;
        R          : inout STD_LOGIC_VECTOR(3 downto 0);
        G          : inout STD_LOGIC_VECTOR(3 downto 0);
        B          : inout STD_LOGIC_VECTOR(3 downto 0);
        Points     : out integer;
        Next_Note  : in integer;
        Iter       : in integer;
        ButtonCond : in STD_LOGIC_VECTOR(4 downto 0);
        GamePeriod : in integer
    );
end component;

component Seven_Segmented_Display
    Port (
        Input_Number : in integer;
        CLK          : in STD_LOGIC;
        Display      : out STD_LOGIC_VECTOR (3 downto 0);
        Segment      : out STD_LOGIC_VECTOR (6 downto 0)
     );
end component;

component music is
    Port ( Clk       : in STD_LOGIC;
           Sound_Top : inout STD_LOGIC);
end component;

begin
    Sound_Actual_Top <= Sound_Actual_Top_Sig;
    Note_P <= PRandomNum mod 5;
    VGA_R <= VGA_R1;
    VGA_G <= VGA_G1;
    VGA_B <= VGA_B1;
--Selecting the period of the game
    with FrequencyInputVector select Period <=
        1 when "11",
        3 when "10",
        5 when "01",  
        2000000000 when others; --Arbitrarily large to essentially stop the game (takes 4 years to change one pixel at this rate)
uut1: clock_iteration_counter Port Map (
    CLK              => CLOCK,
    GamePeriod       => Period,
    PRandomNumber    => PRandomNum,
    IterationCounter => Iteration
    );    
uut2: display_function Port Map (
    CLK        => CLOCK,
    HSYNC      => H_SYNC,
    VSYNC      => V_SYNC,
    R          => VGA_R1,
    G          => VGA_G1,
    B          => VGA_B1,
    Points     => Score,
    Next_Note  => Note_P,
    Iter       => Iteration,
    ButtonCond => NoteInputVector,
    GamePeriod => Period
    );
    TestVector <= std_logic_vector(to_unsigned(Iteration, TestVector'length));        
uut3: Seven_Segmented_Display Port Map (
    Input_Number => Score,
    CLK          => Clock,
    Display      => Display_Select,
    Segment      => Segment_Select
    );
    
uut4: music Port Map (
    Clk       => CLOCK,
    Sound_Top => Sound_Actual_Top_Sig
);
end Behavioral;
