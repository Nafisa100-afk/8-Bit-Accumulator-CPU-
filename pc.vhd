library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        pc_src   : in  STD_LOGIC; -- 0: PC+1, 1: Branch Target (not used in Set 3)
        target   : in  STD_LOGIC_VECTOR(3 downto 0);
        pc_out   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal count : unsigned(3 downto 0) := "0000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                count <= (others => '0');
            else
                if pc_src = '1' then
                    count <= unsigned(target);
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;
    pc_out <= std_logic_vector(count);
end Behavioral;