library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity music is
    Port ( Clk      : in STD_LOGIC;
           Sound_Top: inout STD_LOGIC);
end music;
architecture Behavioral of music is


component Signal_Generator is
    Port ( Clock     : in STD_LOGIC;
           Frequency : in integer;
           Sound     : inout STD_LOGIC);
end component;

Procedure Note_Change (Signal Freq : out integer; Signal Count: in integer; Second, Interval, Freq_In: in integer) is --(100 = 1 second!)
begin
    if Count = (1000000)*Second then
        Freq <= Freq_In;
    end if;
end Note_Change;

Signal Freq : integer := 0;
Signal Count: integer := 0;

begin
uut5: Signal_Generator Port Map (
    Clock     => Clk,
    Frequency => Freq,
    Sound     => Sound_Top
    );
    
    process(Clk)
    begin
        if rising_edge(Clk) then
            Count <= Count + 1;
            ------------------------------------------------ 1st part
            Note_Change(Freq, Count, 200, 50, 440); --a
            Note_Change(Freq, Count, 250, 10, 0);
            
            Note_Change(Freq, Count, 260, 50, 440); --a
            Note_Change(Freq, Count, 310, 10, 0);
            
            Note_Change(Freq, Count, 320, 50, 440); --a
            Note_Change(Freq, Count, 370, 10, 0);
            
            Note_Change(Freq, Count, 380, 35, 349); --f
            Note_Change(Freq, Count, 415, 10, 0);
            
            Note_Change(Freq, Count, 425, 15, 523); --cH
            Note_Change(Freq, Count, 440, 10, 0);
            
            Note_Change(Freq, Count, 450, 50, 440); --a
            Note_Change(Freq, Count, 500, 10, 0);
            
            Note_Change(Freq, Count, 510, 35, 349); --f
            Note_Change(Freq, Count, 545, 10, 0);
                        
            Note_Change(Freq, Count, 555, 15, 523); --cH
            Note_Change(Freq, Count, 570, 10, 0);
            
            Note_Change(Freq, Count, 580, 65, 440); --a
            Note_Change(Freq, Count, 645, 25, 0);
            ------------------------------------------------ 2nd part
            Note_Change(Freq, Count, 670, 50, 659); --eH
            Note_Change(Freq, Count, 720, 10, 0);           
            
            Note_Change(Freq, Count, 730, 50, 659); --eH
            Note_Change(Freq, Count, 780, 10, 0);     
            
            Note_Change(Freq, Count, 790, 50, 659); --eH
            Note_Change(Freq, Count, 840, 10, 0);      
            
            Note_Change(Freq, Count, 850, 35, 698); --fH
            Note_Change(Freq, Count, 885, 10, 0);     
            
            Note_Change(Freq, Count, 895, 15, 523); --cH
            Note_Change(Freq, Count, 910, 10, 0);     
            
            Note_Change(Freq, Count, 920, 50, 415); --gS 
            Note_Change(Freq, Count, 970, 10, 0);     
            
            Note_Change(Freq, Count, 980, 35, 349); --f 
            Note_Change(Freq, Count, 1015, 10, 0);     
            
            Note_Change(Freq, Count, 1025, 15, 523); --cH 
            Note_Change(Freq, Count, 1040, 10, 0);     
            
            Note_Change(Freq, Count, 1050, 65, 440); --a 
            Note_Change(Freq, Count, 1115, 25, 0);   
            ------------------------------------------------ 3rd part
            Note_Change(Freq, Count, 1140, 50, 880); --aH
            Note_Change(Freq, Count, 1190, 10, 0);           
            
            Note_Change(Freq, Count, 1200, 30, 440); --a
            Note_Change(Freq, Count, 1230, 10, 0);     
            
            Note_Change(Freq, Count, 1240, 15, 440); --a
            Note_Change(Freq, Count, 1255, 10, 0);      
            
            Note_Change(Freq, Count, 1265, 40, 880); --aH
            Note_Change(Freq, Count, 1305, 10, 0);     
            
            Note_Change(Freq, Count, 1315, 20, 830); --gSH
            Note_Change(Freq, Count, 1335, 10, 0);     
            
            Note_Change(Freq, Count, 1345, 20, 784); --gH 
            Note_Change(Freq, Count, 1365, 10, 0);     
            
            Note_Change(Freq, Count, 1375, 12, 740); --fsH 
            Note_Change(Freq, Count, 1387, 10, 0);     
            
            Note_Change(Freq, Count, 1397, 13, 698); --fH 
            Note_Change(Freq, Count, 1410, 10, 0);     
            
            Note_Change(Freq, Count, 1420, 25, 740); --fsH 
            Note_Change(Freq, Count, 1445, 35, 0);   
            ------------------------------------------------ 4th part  
            Note_Change(Freq, Count, 1480, 25, 455); --aS
            Note_Change(Freq, Count, 1505, 10, 0);      
            
            Note_Change(Freq, Count, 1515, 40, 622); --dSH
            Note_Change(Freq, Count, 1555, 10, 0);     
            
            Note_Change(Freq, Count, 1565, 20, 587); --dH
            Note_Change(Freq, Count, 1585, 10, 0);     
            
            Note_Change(Freq, Count, 1595, 20, 554); --cSH 
            Note_Change(Freq, Count, 1615, 10, 0);     
            
            Note_Change(Freq, Count, 1625, 12, 523); --cH 
            Note_Change(Freq, Count, 1637, 10, 0);     
            
            Note_Change(Freq, Count, 1647, 13, 466); --b 
            Note_Change(Freq, Count, 1660, 10, 0);     
            
            Note_Change(Freq, Count, 1670, 25, 523); --cH 
            Note_Change(Freq, Count, 1695, 35, 0);            
            ------------------------------------------------  5th part
            Note_Change(Freq, Count, 1730, 12, 349); --f
            Note_Change(Freq, Count, 1742, 10, 0);     
            
            Note_Change(Freq, Count, 1752, 50, 415); --gS
            Note_Change(Freq, Count, 1802, 10, 0);      
            
            Note_Change(Freq, Count, 1812, 38, 349); --f
            Note_Change(Freq, Count, 1840, 10, 0);     
            
            Note_Change(Freq, Count, 1850, 12, 440); --a
            Note_Change(Freq, Count, 1862, 10, 0);     
            
            Note_Change(Freq, Count, 1872, 50, 523); --cH 
            Note_Change(Freq, Count, 1922, 10, 0);     
            
            Note_Change(Freq, Count, 1932, 38, 440); --a 
            Note_Change(Freq, Count, 1970, 10, 0);     
            
            Note_Change(Freq, Count, 1980, 13, 523); --cH 
            Note_Change(Freq, Count, 1993, 10, 0);     
            
            Note_Change(Freq, Count, 2003, 65, 659); --eH 
            Note_Change(Freq, Count, 2068, 35, 0);   
            ------------------------------------------------  6th part
            Note_Change(Freq, Count, 2103, 50, 880); --aH
            Note_Change(Freq, Count, 2153, 10, 0);           
            
            Note_Change(Freq, Count, 2163, 30, 440); --a
            Note_Change(Freq, Count, 2193, 10, 0);     
            
            Note_Change(Freq, Count, 2203, 15, 440); --a
            Note_Change(Freq, Count, 2218, 10, 0);      
            
            Note_Change(Freq, Count, 2228, 40, 880); --aH
            Note_Change(Freq, Count, 2268, 10, 0);     
            
            Note_Change(Freq, Count, 2278, 20, 830); --gSH
            Note_Change(Freq, Count, 2298, 10, 0);     
            
            Note_Change(Freq, Count, 2308, 20, 784); --gH 
            Note_Change(Freq, Count, 2328, 10, 0);     
            
            Note_Change(Freq, Count, 2338, 12, 740); --fsH 
            Note_Change(Freq, Count, 2350, 10, 0);     
            
            Note_Change(Freq, Count, 2360, 13, 698); --fH 
            Note_Change(Freq, Count, 2373, 10, 0);     
            
            Note_Change(Freq, Count, 2383, 25, 740); --fsH 
            Note_Change(Freq, Count, 2408, 35, 0);   
            ------------------------------------------------ 7th part  
            Note_Change(Freq, Count, 2443, 25, 455); --aS
            Note_Change(Freq, Count, 2468, 10, 0);      
            
            Note_Change(Freq, Count, 2478, 40, 622); --dSH
            Note_Change(Freq, Count, 2518, 10, 0);     
            
            Note_Change(Freq, Count, 2528, 20, 587); --dH
            Note_Change(Freq, Count, 2548, 10, 0);     
            
            Note_Change(Freq, Count, 2558, 20, 554); --cSH 
            Note_Change(Freq, Count, 2578, 10, 0);     
            
            Note_Change(Freq, Count, 2588, 12, 523); --cH 
            Note_Change(Freq, Count, 2600, 10, 0);     
            
            Note_Change(Freq, Count, 2610, 13, 466); --b 
            Note_Change(Freq, Count, 2623, 10, 0);     
            
            Note_Change(Freq, Count, 2633, 25, 523); --cH 
            Note_Change(Freq, Count, 2658, 35, 0);            
            ------------------------------------------------  8th part
            Note_Change(Freq, Count, 2693, 25, 349); --f
            Note_Change(Freq, Count, 2718, 10, 0);     
            
            Note_Change(Freq, Count, 2728, 50, 415); --gS
            Note_Change(Freq, Count, 2778, 10, 0);      
            
            Note_Change(Freq, Count, 2788, 38, 349); --f
            Note_Change(Freq, Count, 2826, 10, 0);     
            
            Note_Change(Freq, Count, 2836, 12, 523); --cH
            Note_Change(Freq, Count, 2848, 10, 0);     
            
            Note_Change(Freq, Count, 2858, 50, 440); --a 
            Note_Change(Freq, Count, 2908, 10, 0);     
            
            Note_Change(Freq, Count, 2918, 38, 349); --f 
            Note_Change(Freq, Count, 2956, 10, 0);     
            
            Note_Change(Freq, Count, 2966, 13, 523); --cH 
            Note_Change(Freq, Count, 2979, 10, 0);     
            
            Note_Change(Freq, Count, 2989, 65, 440); --a 
            Note_Change(Freq, Count, 3054, 35, 0);
            
            if Count = 1000000*3089 then --Resetting the count at the end of the song
                Count <= 0;
            end if;
        end if;
        
    end process;

end Behavioral;