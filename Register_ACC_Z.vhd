library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Register_ACC_Z is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        alu_res   : in  STD_LOGIC_VECTOR(7 downto 0);
        alu_z     : in  STD_LOGIC;
        acc_out   : out STD_LOGIC_VECTOR(7 downto 0);
        z_out     : out STD_LOGIC
    );
end Register_ACC_Z;

architecture Behavioral of Register_ACC_Z is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                acc_out <= (others => '0');
                z_out   <= '1';
            else
                acc_out <= alu_res;
                z_out   <= alu_z;
            end if;
        end if;
    end process;
end Behavioral;