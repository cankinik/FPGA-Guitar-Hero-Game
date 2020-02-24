library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.all;
entity clock_iteration_counter is
    Port ( CLK              : in STD_LOGIC;
           GamePeriod       : in integer;
           PRandomNumber    : out integer;
           IterationCounter : out integer
           );
end clock_iteration_counter;
architecture Behavioral of clock_iteration_counter is
--Variables and Signals
CONSTANT CLOCK_FREQUENCY : integer := 100000000; --100MHz, the inner clock working frequency of BASYS3
SIGNAL Iteration    : integer := 0;
SIGNAL TickCounter  : integer := 0;
SIGNAL LFSR         : std_logic_vector (7 downto 0) := "00000001";
begin
    process( CLK )        
    VARIABLE NEXT_LFSR    : std_logic_vector (7 downto 0);
    VARIABLE FEEDBACK     : std_logic;
    
    begin 
    if( rising_edge(CLK) ) then
        FEEDBACK  := ( ( LFSR(3) xor LFSR(4) ) xor LFSR(2) ) xor LFSR(0); 
        NEXT_LFSR := LFSR(6 downto 0) & FEEDBACK;
        TickCounter <= TickCounter + 1;        
    end if;
    if TickCounter >= ((CLOCK_FREQUENCY) * GamePeriod) / 5  then --Has a period of 128 different notes for 00000001
        TickCounter <= 0;
        Iteration <= Iteration + 1;
        IterationCounter <= Iteration;
        LFSR <= NEXT_LFSR;       
        PRandomNumber <= to_integer( unsigned(LFSR) );
    end if;
    
    end process;
    
end Behavioral;