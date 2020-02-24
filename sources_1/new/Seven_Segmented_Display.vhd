library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Seven_Segmented_Display is
  Port (
        Input_Number : in integer;
        CLK        : in STD_LOGIC;
        Display      : out STD_LOGIC_VECTOR (3 downto 0);
        Segment      : out STD_LOGIC_VECTOR (6 downto 0)
         );
end Seven_Segmented_Display;
architecture Behavioral of Seven_Segmented_Display is
SIGNAL Temp_Number       : integer;
SIGNAL Input_Number_0    : integer;
SIGNAL Input_Number_1    : integer;
SIGNAL Input_Number_2    : integer;
SIGNAL Input_Number_3    : integer;
SIGNAL Temp              : STD_LOGIC_VECTOR(6 downto 0); --Reversed to match
SIGNAL Slow_Clock        : STD_LOGIC;
begin
Input_Number_0  <=  Input_Number mod 10;
Input_Number_1  <= (Input_Number / 10) mod 10;
Input_Number_2  <= (Input_Number / 100) mod 10;
Input_Number_3  <= (Input_Number / 1000) mod 10;
--Decoder
with Temp_Number select 
Temp <= 
    "1111110" when 0, --Stands for 0
    "0110000" when 1, --Stands for 1
    "1101101" when 2, --Stands for 2
    "1111001" when 3, --Stands for 3
    "0110011" when 4, --Stands for 4
    "1011011" when 5, --Stands for 5
    "1011111" when 6, --Stands for 6
    "1110000" when 7, --Stands for 7
    "1111111" when 8, --Stands for 8
    "1111011" when 9, --Stands for 9
    "1001111" when others; --Stands for E : Error 
    --Active low so using not
    Segment(0) <= not Temp(6);
    Segment(1) <= not Temp(5);
    Segment(2) <= not Temp(4);
    Segment(3) <= not Temp(3);
    Segment(4) <= not Temp(2);
    Segment(5) <= not Temp(1);
    Segment(6) <= not Temp(0);
    process(CLK)
    VARIABLE Clock_Counter     : STD_LOGIC_VECTOR(15 downto 0);
    VARIABLE Display_Iteration : integer range 3 downto 0;
    begin    
    --Slowing down the clock
    if rising_edge(CLK) then
        Clock_Counter := Clock_Counter + 1;
        Slow_Clock <= Clock_Counter(15);
    end if;
    --Iterating between the selected displays and their inputs, remember that the signal is active low here
    --Using the Slow_Clock so that the refresh rate is appropriate
    if rising_edge(Slow_Clock) then    
        Display <= (others => '1');
        Display(Display_Iteration) <= '0';
        case Display_Iteration is 
        when 0 => 
            Temp_Number <= Input_Number_0;      
        when 1 =>
            Temp_Number <= Input_Number_1;
        when 2 =>
            Temp_Number <= Input_Number_2;
        when others =>
            Temp_Number <= Input_Number_3;
        end case;
        Display_Iteration := Display_Iteration + 1;
    end if;
    end process;
end Behavioral;