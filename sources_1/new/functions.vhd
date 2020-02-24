library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.all;

PACKAGE Functions is    
    PROCEDURE Draw_Square    ( SIGNAL Current_X,Current_Y,Position_X,Position_Y, Size: in INTEGER; SIGNAL Turn : out STD_LOGIC );     
    PROCEDURE Stream_Note    ( SIGNAL Pos_Y, Pixel_Increase, Note_Box_Size : in INTEGER; SIGNAL Draw : inout STD_LOGIC; SIGNAL Pos_YO : out integer );
    PROCEDURE Next_Note_Draw (SIGNAL Draw1, Draw2, Draw3, Draw4 : inout STD_LOGIC);
    PROCEDURE Square_RGB     (SIGNAL Turn : STD_LOGIC; SIGNAL R, G, B : inout STD_LOGIC_VECTOR; SIGNAL Color : in STD_LOGIC_VECTOR (2 downto 0));
    PROCEDURE Trig_Update    (SIGNAL Trig1, Trig2, Trig3, Trig4 : in STD_LOGIC; SIGNAL Pos1, Pos2, Pos3, Pos4, Point, Note_Box_Size, Box_Color_Count : inout integer; SIGNAL Draw1, Draw2, Draw3, Draw4 : inout STD_LOGIC; SIGNAL Box_Color : inout STD_LOGIC_VECTOR (2 downto 0));
    PROCEDURE Color_Change   (SIGNAL Box_Color : inout STD_LOGIC_VECTOR(2 downto 0); SIGNAL Box_Color_Count : inout integer);
    CONSTANT VERTICAL_TOT   : integer := 932;
    CONSTANT VERTICAL_BN    : integer := 32;
END Functions;

PACKAGE BODY Functions IS
    PROCEDURE Draw_Square ( SIGNAL Current_X,Current_Y,Position_X,Position_Y, Size: in INTEGER; SIGNAL Turn : out STD_LOGIC ) is
    BEGIN
        if ( Current_X > Position_X and Current_X < ( Position_X + Size ) and Current_Y > Position_Y and Current_Y < ( Position_Y + Size ) )then --Conditions contiued
            Turn <= '1';
        else
            Turn <= '0';
        end IF; 
    END Draw_Square;  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE Stream_Note ( SIGNAL Pos_Y, Pixel_Increase, Note_Box_Size : IN INTEGER; SIGNAL Draw : INOUT STD_LOGIC; SIGNAL Pos_YO : out integer ) IS 
        BEGIN 
            if Pos_Y < VERTICAL_TOT and Draw = '1' then
                Pos_YO <= Pos_Y + Pixel_Increase;
            else
                Pos_YO <= VERTICAL_BN - Note_Box_Size;
                if Draw = '1' then
                    Draw <= '0';
                end if;
            end if;
        END Stream_Note;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE Next_Note_Draw (SIGNAL Draw1, Draw2, Draw3, Draw4 : INOUT STD_LOGIC) IS
    BEGIN
        if Draw1 = '0' then
            Draw1 <= '1';
        else
            Draw1 <= '1';
            if Draw2 = '0' then
                Draw2 <= '1';
            else
                Draw2 <= '1';
                if Draw3 = '0' then
                    Draw3 <= '1';
                else
                    Draw3 <= '1';
                    if Draw4 = '0' then
                        Draw4 <= '1';
                    else
                        Draw4 <= '1';
                    end if;
                end if;
            end if;
        end if;
    END Next_Note_Draw;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE Square_RGB     (SIGNAL Turn : STD_LOGIC; SIGNAL R, G, B : inout STD_LOGIC_VECTOR; SIGNAL Color : in STD_LOGIC_VECTOR (2 downto 0)) IS
    BEGIN
        if Turn = '1' then
            if Color = "000" then    --Red
                R <= "1111";
                G <= "0000";
                B <= "0000"; 
            elsif Color = "001" then --Green
                R <= "0000";
                G <= "1111";
                B <= "0000"; 
            elsif Color = "010" then --Blue
                R <= "0000";
                G <= "0000";
                B <= "1111"; 
            elsif Color = "011" then --Orange
                R <= "1111";
                G <= "0111";
                B <= "0000"; 
            elsif Color = "100" then --Yellow
                R <= "1111";
                G <= "1111";
                B <= "0000"; 
            elsif Color = "101" then --Magenta
                R <= "1111";
                G <= "0000";
                B <= "1111"; 
            elsif Color = "110" then --Cyan
                R <= "0000";
                G <= "1111";
                B <= "1111"; 
            else                     --Purple
                R <= "1000";
                G <= "0000";
                B <= "1000"; 
            end if;            
        end if;
    END Square_RGB;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE Trig_Update    (SIGNAL Trig1, Trig2, Trig3, Trig4 : in STD_LOGIC; SIGNAL Pos1, Pos2, Pos3, Pos4, Point, Note_Box_Size, Box_Color_Count : inout integer; SIGNAL Draw1, Draw2, Draw3, Draw4 : inout STD_LOGIC; SIGNAL Box_Color : inout STD_LOGIC_VECTOR (2 downto 0)) IS
    BEGIN
        if Trig1 = '1' or Trig2 = '1' or Trig3 = '1' or Trig4 = '1'then
            Point <= Point + 1; --Correct Input
            Box_Color <= "001";
            Box_Color_Count <= 30000000;
            if Trig1 = '1' then
                Pos1 <= VERTICAL_BN - Note_Box_Size;
                Draw1 <= '0';
            elsif Trig2 = '1' then
                Pos2 <= VERTICAL_BN - Note_Box_Size;
                Draw2 <= '0';
            elsif Trig3 = '1' then
                Pos3 <= VERTICAL_BN - Note_Box_Size;
                Draw3 <= '0';
            else
                Pos4 <= VERTICAL_BN - Note_Box_Size;
                Draw4 <= '0';
            end if;
        end if;
    END Trig_Update;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    PROCEDURE Color_Change   (SIGNAL Box_Color : inout STD_LOGIC_VECTOR(2 downto 0); SIGNAL Box_Color_Count : inout integer) IS
    BEGIN
        if Box_Color_Count /= 0 then
            Box_Color_Count <= Box_Color_Count - 1;
        else
            Box_Color <= "100";
            Box_Color_Count <= 0; --Just in case of an error :)
        end if;
    END Color_Change;
END Functions;