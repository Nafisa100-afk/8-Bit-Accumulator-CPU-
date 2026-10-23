library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
    Port (
        opcode : in  STD_LOGIC_VECTOR(3 downto 0);
        alu_op : out STD_LOGIC_VECTOR(2 downto 0)
    );
end Control_Unit;

architecture Behavioral of Control_Unit is
begin
    process(opcode)
    begin
        case opcode is
            when "0001" => alu_op <= "000"; -- LDI
            when "0010" => alu_op <= "001"; -- ADD
            when "0011" => alu_op <= "010"; -- SUB
            when "0110" => alu_op <= "011"; -- XOR
            when "1001" => alu_op <= "100"; -- SHR
            when others => alu_op <= "111"; -- NOP
        end case;
    end process;
end Behavioral;