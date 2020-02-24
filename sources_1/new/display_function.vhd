library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.all;
use WORK.Functions.ALL;

entity display_function is
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
end display_function;
architecture Behavioral of display_function is
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CONSTANT HORIZONTAL_RES : integer := 1440;
CONSTANT HORIZONTAL_FP  : integer := 80;
CONSTANT HORIZONTAL_BP  : integer := 232;
CONSTANT HORIZONTAL_SYN : integer := 152;
CONSTANT HORIZONTAL_BN  : integer := HORIZONTAL_FP + HORIZONTAL_BP + HORIZONTAL_SYN;
CONSTANT HORIZONTAL_TOT : integer := HORIZONTAL_BN + HORIZONTAL_RES;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CONSTANT VERTICAL_RES   : integer := 900;
CONSTANT VERTICAL_FP    : integer := 1;
CONSTANT VERTICAL_BP    : integer := 28;
CONSTANT VERTICAL_SYN   : integer := 3;
CONSTANT VERTICAL_BN    : integer := VERTICAL_FP + VERTICAL_BP + VERTICAL_SYN;
CONSTANT VERTICAL_TOT   : integer := VERTICAL_BN + VERTICAL_RES;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CONSTANT SPACE_MARGIN      : integer := 10;
CONSTANT LEFT_LINE         : integer := ( HORIZONTAL_RES / 3) + HORIZONTAL_BN;
CONSTANT RIGHT_LINE        : integer := ( 2 * HORIZONTAL_RES / 3) + HORIZONTAL_BN;
CONSTANT STATIC_SQUARE_SIZE: integer := ( RIGHT_LINE - LEFT_LINE - 5 * SPACE_MARGIN ) / 4;
CONSTANT NOTE_SQUARE_SIZE  : integer := STATIC_SQUARE_SIZE - SPACE_MARGIN;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CONSTANT DISPLAY_REFRESH: integer := 100000000 / (HORIZONTAL_TOT * VERTICAL_TOT); --In Hz
CONSTANT PIXEL_SECOND   : integer := (VERTICAL_RES - 2 * SPACE_MARGIN) / DISPLAY_REFRESH;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SIGNAL HPOS           : integer RANGE 0 TO HORIZONTAL_TOT := 0;
SIGNAL VPOS           : integer RANGE 0 TO VERTICAL_TOT   := 0;
SIGNAL Pixel_Increase : integer := PIXEL_SECOND / GamePeriod;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SIGNAL Static_Box_Size    : integer := STATIC_SQUARE_SIZE;
SIGNAL Static_Box_Vertical: integer := VERTICAL_TOT - SPACE_MARGIN - Static_Box_Size;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SIGNAL Position_X1  : integer := LEFT_LINE + SPACE_MARGIN;
SIGNAL Position_X2  : integer := LEFT_LINE + 2 * SPACE_MARGIN + STATIC_SQUARE_SIZE;
SIGNAL Position_X3  : integer := LEFT_LINE + 3 * SPACE_MARGIN + 2 * STATIC_SQUARE_SIZE;
SIGNAL Position_X4  : integer := LEFT_LINE + 4 * SPACE_MARGIN + 3 * STATIC_SQUARE_SIZE;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SIGNAL Note_Box_Size : integer := NOTE_SQUARE_SIZE;
SIGNAL Note_Box_Col1 : integer := Position_X1 + SPACE_MARGIN/2;
SIGNAL Note_Box_Col2 : integer := Position_X2 + SPACE_MARGIN/2;
SIGNAL Note_Box_Col3 : integer := Position_X3 + SPACE_MARGIN/2;
SIGNAL Note_Box_Col4 : integer := Position_X4 + SPACE_MARGIN/2;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SIGNAL Position_Y11, Position_Y12, Position_Y13, Position_Y14, Position_Y21, Position_Y22, Position_Y23, Position_Y24 : integer := VERTICAL_BN - Note_Box_Size;
SIGNAL Position_Y31, Position_Y32, Position_Y33, Position_Y34, Position_Y41, Position_Y42, Position_Y43, Position_Y44 : integer := VERTICAL_BN - Note_Box_Size;

SIGNAL Draw11, Draw12, Draw13, Draw14, Draw21, Draw22, Draw23, Draw24, Draw31, Draw32, Draw33, Draw34, Draw41, Draw42, Draw43, Draw44 : STD_LOGIC := '0';

SIGNAL PIter  : integer   := 0;
SIGNAL Point  : integer   := 0;
SIGNAL PrevCond : STD_LOGIC_VECTOR (3 downto 0) := "0000";
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SIGNAL Trig11, Trig12, Trig13, Trig14, Trig21, Trig22, Trig23, Trig24, Trig31, Trig32, Trig33, Trig34, Trig41, Trig42, Trig43, Trig44 : STD_LOGIC := '0';
SIGNAL Turn11, Turn12, Turn13, Turn14, Turn21, Turn22, Turn23, Turn24, Turn31, Turn32, Turn33, Turn34, Turn41, Turn42, Turn43, Turn44 : STD_LOGIC;
SIGNAL TurnX_1, TurnX_2, TurnX_3, TurnX_4 : STD_LOGIC;
--Colors
SIGNAL Red     : STD_LOGIC_VECTOR (2 downto 0) := "000";
SIGNAL Green   : STD_LOGIC_VECTOR (2 downto 0) := "001";
SIGNAL Blue    : STD_LOGIC_VECTOR (2 downto 0) := "010";
SIGNAL Orange  : STD_LOGIC_VECTOR (2 downto 0) := "011";
SIGNAL Yellow  : STD_LOGIC_VECTOR (2 downto 0) := "100";
SIGNAL Magenta : STD_LOGIC_VECTOR (2 downto 0) := "101";
SIGNAL Cyan    : STD_LOGIC_VECTOR (2 downto 0) := "110";
SIGNAL Purple  : STD_LOGIC_VECTOR (2 downto 0) := "111";

SIGNAL Box1_Color, Box2_Color, Box3_Color, Box4_Color : STD_LOGIC_VECTOR (2 downto 0) := Yellow;

SIGNAL Box1_Color_Count, Box2_Color_Count, Box3_Color_Count, Box4_Color_Count : integer := 0; 
begin
--Adding the static boxes
    Draw_Square ( HPOS, VPOS, Position_X1, Static_Box_Vertical, Static_Box_Size, TurnX_1);    
    Draw_Square ( HPOS, VPOS, Position_X2, Static_Box_Vertical, Static_Box_Size, TurnX_2);    
    Draw_Square ( HPOS, VPOS, Position_X3, Static_Box_Vertical, Static_Box_Size, TurnX_3);
    Draw_Square ( HPOS, VPOS, Position_X4, Static_Box_Vertical, Static_Box_Size, TurnX_4);
--Adding the note boxes
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Draw_Square ( HPOS, VPOS, Note_Box_Col1, Position_Y11, Note_Box_Size, Turn11);    
    Draw_Square ( HPOS, VPOS, Note_Box_Col1, Position_Y12, Note_Box_Size, Turn12);
    Draw_Square ( HPOS, VPOS, Note_Box_Col1, Position_Y13, Note_Box_Size, Turn13);
    Draw_Square ( HPOS, VPOS, Note_Box_Col1, Position_Y14, Note_Box_Size, Turn14);
    Draw_Square ( HPOS, VPOS, Note_Box_Col2, Position_Y21, Note_Box_Size, Turn21);    
    Draw_Square ( HPOS, VPOS, Note_Box_Col2, Position_Y22, Note_Box_Size, Turn22);
    Draw_Square ( HPOS, VPOS, Note_Box_Col2, Position_Y23, Note_Box_Size, Turn23);
    Draw_Square ( HPOS, VPOS, Note_Box_Col2, Position_Y24, Note_Box_Size, Turn24);
    Draw_Square ( HPOS, VPOS, Note_Box_Col3, Position_Y31, Note_Box_Size, Turn31);
    Draw_Square ( HPOS, VPOS, Note_Box_Col3, Position_Y32, Note_Box_Size, Turn32);
    Draw_Square ( HPOS, VPOS, Note_Box_Col3, Position_Y33, Note_Box_Size, Turn33);
    Draw_Square ( HPOS, VPOS, Note_Box_Col3, Position_Y34, Note_Box_Size, Turn34);
    Draw_Square ( HPOS, VPOS, Note_Box_Col4, Position_Y41, Note_Box_Size, Turn41);
    Draw_Square ( HPOS, VPOS, Note_Box_Col4, Position_Y42, Note_Box_Size, Turn42);
    Draw_Square ( HPOS, VPOS, Note_Box_Col4, Position_Y43, Note_Box_Size, Turn43);
    Draw_Square ( HPOS, VPOS, Note_Box_Col4, Position_Y44, Note_Box_Size, Turn44);
--Condition if a note is currently in the Box area to be registered when the corresponding button is pressed
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    Trig11 <= Turn11 and TurnX_1;--'1' when (Position_Y11 >= Static_Box_Vertical or Position_Y11 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig12 <= Turn12 and TurnX_1;--'1' when (Position_Y12 >= Static_Box_Vertical or Position_Y12 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig13 <= Turn13 and TurnX_1;--'1' when (Position_Y13 >= Static_Box_Vertical or Position_Y13 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig14 <= Turn14 and TurnX_1;--'1' when (Position_Y14 >= Static_Box_Vertical or Position_Y14 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig21 <= Turn21 and TurnX_2;--'1' when (Position_Y21 >= Static_Box_Vertical or Position_Y21 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig22 <= Turn22 and TurnX_2;--'1' when (Position_Y22 >= Static_Box_Vertical or Position_Y22 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig23 <= Turn23 and TurnX_2;--'1' when (Position_Y23 >= Static_Box_Vertical or Position_Y23 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig24 <= Turn24 and TurnX_2;--'1' when (Position_Y24 >= Static_Box_Vertical or Position_Y24 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig31 <= Turn31 and TurnX_3;--'1' when (Position_Y31 >= Static_Box_Vertical or Position_Y31 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig32 <= Turn32 and TurnX_3;--'1' when (Position_Y32 >= Static_Box_Vertical or Position_Y32 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig33 <= Turn33 and TurnX_3;--'1' when (Position_Y33 >= Static_Box_Vertical or Position_Y33 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig34 <= Turn34 and TurnX_3;--'1' when (Position_Y34 >= Static_Box_Vertical or Position_Y34 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig41 <= Turn41 and TurnX_4;--'1' when (Position_Y41 >= Static_Box_Vertical or Position_Y41 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig42 <= Turn42 and TurnX_4;--'1' when (Position_Y42 >= Static_Box_Vertical or Position_Y42 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig43 <= Turn43 and TurnX_4;--'1' when (Position_Y43 >= Static_Box_Vertical or Position_Y43 < (Static_Box_Vertical + Static_Box_Size)) else '0';
    Trig44 <= Turn44 and TurnX_4;--'1' when (Position_Y44 >= Static_Box_Vertical or Position_Y44 < (Static_Box_Vertical + Static_Box_Size)) else '0';

    Points <= Point;    
    process(CLK) --Iterates through each pixel on the screen
    begin
        if( rising_edge(CLK) )then
            --Drawing the next note at each iteration
            if PIter /= Iter then 
                if Next_Note = 1 then
                    Next_Note_Draw(Draw11, Draw12, Draw13, Draw14);                
                elsif Next_Note = 2 then
                    Next_Note_Draw(Draw21, Draw22, Draw23, Draw24);      
                elsif Next_Note = 3 then
                    Next_Note_Draw(Draw31, Draw32, Draw33, Draw34);      
                elsif Next_Note = 4 then
                    Next_Note_Draw(Draw41, Draw42, Draw43, Draw44);     
                end if;
                PIter <= Iter;
            end if;
            --If the color has been changed by the trig update procedure, then this one detects the change in count and decrements, when 0, makes the color yellow
            Color_Change(Box1_Color, Box1_Color_Count); 
            Color_Change(Box2_Color, Box2_Color_Count); 
            Color_Change(Box3_Color, Box3_Color_Count); 
            Color_Change(Box4_Color, Box4_Color_Count); 
            
            if( HPOS < HORIZONTAL_TOT )then
                HPOS <= HPOS+1;
            else
                HPOS <= 0;
                if( VPOS < VERTICAL_TOT )then
                    VPOS <= VPOS+1;
                else
                    VPOS <= 0; 
                --Occurs every refresh of the display: DISPLAY_REFRESH amount of times in one second        
                    Stream_Note(Position_Y11, Pixel_Increase, Note_Box_Size, Draw11, Position_Y11);
                    Stream_Note(Position_Y12, Pixel_Increase, Note_Box_Size, Draw12, Position_Y12);
                    Stream_Note(Position_Y13, Pixel_Increase, Note_Box_Size, Draw13, Position_Y13);
                    Stream_Note(Position_Y14, Pixel_Increase, Note_Box_Size, Draw14, Position_Y14);
                    Stream_Note(Position_Y21, Pixel_Increase, Note_Box_Size, Draw21, Position_Y21);
                    Stream_Note(Position_Y22, Pixel_Increase, Note_Box_Size, Draw22, Position_Y22);
                    Stream_Note(Position_Y23, Pixel_Increase, Note_Box_Size, Draw23, Position_Y23);
                    Stream_Note(Position_Y24, Pixel_Increase, Note_Box_Size, Draw24, Position_Y24);
                    Stream_Note(Position_Y31, Pixel_Increase, Note_Box_Size, Draw31, Position_Y31);
                    Stream_Note(Position_Y32, Pixel_Increase, Note_Box_Size, Draw32, Position_Y32);
                    Stream_Note(Position_Y33, Pixel_Increase, Note_Box_Size, Draw33, Position_Y33);
                    Stream_Note(Position_Y34, Pixel_Increase, Note_Box_Size, Draw34, Position_Y34);
                    Stream_Note(Position_Y41, Pixel_Increase, Note_Box_Size, Draw41, Position_Y41);
                    Stream_Note(Position_Y42, Pixel_Increase, Note_Box_Size, Draw42, Position_Y42);
                    Stream_Note(Position_Y43, Pixel_Increase, Note_Box_Size, Draw43, Position_Y43);
                    Stream_Note(Position_Y44, Pixel_Increase, Note_Box_Size, Draw44, Position_Y44);                        
                end if;
            end if;
            --Point calculation                         "00000" = 0, "0---1" = 1, "0--10" = 2, "0-100" = 3, "01000" = 4 in notes, "1----" = reset score
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            if ButtonCond(4) = '1' then --Score reset
                Point <= 0;
            elsif ButtonCond /= "00000" then 
                if ButtonCond(0) = '1' then
                    Trig_Update(Trig11, Trig12, Trig13, Trig14, Position_Y11, Position_Y12, Position_Y13, Position_Y14, Point, Note_Box_Size, Box1_Color_Count, Draw11, Draw12, Draw13, Draw14, Box1_Color);
                elsif ButtonCond(1) = '1' then
                    Trig_Update(Trig21, Trig22, Trig23, Trig24, Position_Y21, Position_Y22, Position_Y23, Position_Y24, Point, Note_Box_Size, Box2_Color_Count, Draw21, Draw22, Draw23, Draw24, Box2_Color);
                elsif ButtonCond(2) = '1' then
                    Trig_Update(Trig31, Trig32, Trig33, Trig34, Position_Y31, Position_Y32, Position_Y33, Position_Y34, Point, Note_Box_Size, Box3_Color_Count, Draw31, Draw32, Draw33, Draw34, Box3_Color);
                elsif ButtonCond(3) = '1' then
                    Trig_Update(Trig41, Trig42, Trig43, Trig44, Position_Y41, Position_Y42, Position_Y43, Position_Y44, Point, Note_Box_Size, Box4_Color_Count, Draw41, Draw42, Draw43, Draw44, Box4_Color);
                end if;
            end if;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            --Static components : Two lines dividing the screen by: 1/3, 1/3, 1/3
            if HPOS = LEFT_LINE  OR HPOS = RIGHT_LINE then
                R <= "1111";
                G <= "1111";
                B <= "1111";
            else 
                R <= "0000";
                G <= "0000";
                B <= "0000";
            end if; 
            --Box components being drawn through their respective "Turn" signal to control the RGB
            Square_RGB  (TurnX_1, R, G, B, Box1_Color);
            Square_RGB  (TurnX_2, R, G, B, Box2_Color);
            Square_RGB  (TurnX_3, R, G, B, Box3_Color);
            Square_RGB  (TurnX_4, R, G, B, Box4_Color);
            Square_RGB  (Turn11,  R, G, B, Orange);
            Square_RGB  (Turn12,  R, G, B, Orange);
            Square_RGB  (Turn13,  R, G, B, Orange);
            Square_RGB  (Turn14,  R, G, B, Orange);
            Square_RGB  (Turn21,  R, G, B, Blue);
            Square_RGB  (Turn22,  R, G, B, Blue);
            Square_RGB  (Turn23,  R, G, B, Blue);
            Square_RGB  (Turn24,  R, G, B, Blue);
            Square_RGB  (Turn31,  R, G, B, Magenta);
            Square_RGB  (Turn32,  R, G, B, Magenta);
            Square_RGB  (Turn33,  R, G, B, Magenta);
            Square_RGB  (Turn34,  R, G, B, Magenta);
            Square_RGB  (Turn41,  R, G, B, Cyan);
            Square_RGB  (Turn42,  R, G, B, Cyan);
            Square_RGB  (Turn43,  R, G, B, Cyan);
            Square_RGB  (Turn44,  R, G, B, Cyan);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            if( HPOS > HORIZONTAL_FP AND HPOS < HORIZONTAL_BP )then --Horizontal sync between FP and BP
                HSYNC <= '0';
            else
                HSYNC <= '1';
            end if;
            if( VPOS > VERTICAL_FP AND VPOS < VERTICAL_BP )then  --Vertical sync between FP and BP
                VSYNC <= '0';
            else
                VSYNC <= '1';
            end if;
            if( ( HPOS > 0 AND HPOS < HORIZONTAL_BN ) OR ( VPOS > 0 AND VPOS < VERTICAL_BN ) )then  --Putting black at non-active zones (BN)
                R<=(others=>'0');
                G<=(others=>'0');
                B<=(others=>'0');
            end if;
        end if;
        
     end process;
end Behavioral;