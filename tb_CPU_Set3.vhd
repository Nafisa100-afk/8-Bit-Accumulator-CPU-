library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_CPU_Set3 is
end tb_CPU_Set3;

architecture Behavioral of tb_CPU_Set3 is
    signal CLK    : STD_LOGIC := '0';
    signal RESET  : STD_LOGIC := '0';
    signal Q      : STD_LOGIC_VECTOR(7 downto 0);
    signal Z      : STD_LOGIC;
    signal PC_out : STD_LOGIC_VECTOR(3 downto 0);

    -- 10 ns clock period = 100 MHz clock frequency
    constant CLK_PERIOD : time := 10 ns;
begin

    -- Instantiate the CPU Top-Level Unit
    uut: entity work.CPU_Set3
        port map (
            CLK    => CLK,
            RESET  => RESET,
            Q      => Q,
            Z      => Z,
            PC_out => PC_out
        );

    -- Precise Clock Process
    CLK_process : process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2; -- 5 ns
        CLK <= '1';
        wait for CLK_PERIOD / 2; -- 5 ns
    end process;

    -- Stimulus Process
    stim_proc: process
    begin
        -- Hold RESET high for 1 full clock cycle
        RESET <= '1';
        wait for CLK_PERIOD; -- 10 ns
        
        -- Release RESET and run program
        RESET <= '0';
        wait for CLK_PERIOD * 10; -- Run for 100 ns total

        -- Stop simulation
        wait;
    end process;

end Behavioral;