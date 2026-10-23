library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        acc     : in  STD_LOGIC_VECTOR(7 downto 0);
        operand : in  STD_LOGIC_VECTOR(7 downto 0);
        alu_op  : in  STD_LOGIC_VECTOR(2 downto 0);
        result  : out STD_LOGIC_VECTOR(7 downto 0);
        z_flag  : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is
    signal res_internal : STD_LOGIC_VECTOR(7 downto 0);
begin
    process(acc, operand, alu_op)
    begin
        case alu_op is
            when "000" => -- LDI
                res_internal <= operand;
            when "001" => -- ADD
                res_internal <= std_logic_vector(unsigned(acc) + unsigned(operand));
            when "010" => -- SUB
                res_internal <= std_logic_vector(unsigned(acc) - unsigned(operand));
            when "011" => -- XOR
                res_internal <= acc xor operand;
            when "100" => -- SHR
                res_internal <= '0' & acc(7 downto 1);
            when others => -- NOP
                res_internal <= acc;
        end case;
    end process;

    result <= res_internal;
    z_flag <= '1' when res_internal = "00000000" else '0';
end Behavioral;