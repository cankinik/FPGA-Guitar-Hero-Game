library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Signal_Generator is
    Port ( Clock     : in STD_LOGIC;
           Frequency : in integer;
           Sound     : inout STD_LOGIC);
end Signal_Generator;

architecture Behavioral of Signal_Generator is
Signal Count : integer := 0;
begin
    process(Clock)
    begin
        if rising_edge(Clock) then
            Count <= Count + 1;
            if Count >= (50000000)/Frequency then
                Sound <= not(Sound);
                Count <= 0;
            end if;
        end if;
    end process;

end Behavioral;