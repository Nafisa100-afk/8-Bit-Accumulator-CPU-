library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_Set3 is
    Port (
        CLK   : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC_VECTOR(7 downto 0);
        Z     : out STD_LOGIC;
        PC_out: out STD_LOGIC_VECTOR(3 downto 0)
    );
end CPU_Set3;

architecture Structural of CPU_Set3 is

    component PC is
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            pc_src   : in  STD_LOGIC;
            target   : in  STD_LOGIC_VECTOR(3 downto 0);
            pc_out   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component Program_ROM is
        Port (
            addr  : in  STD_LOGIC_VECTOR(3 downto 0);
            instr : out STD_LOGIC_VECTOR(11 downto 0)
        );
    end component;

    component Control_Unit is
        Port (
            opcode : in  STD_LOGIC_VECTOR(3 downto 0);
            alu_op : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    component ALU is
        Port (
            acc     : in  STD_LOGIC_VECTOR(7 downto 0);
            operand : in  STD_LOGIC_VECTOR(7 downto 0);
            alu_op  : in  STD_LOGIC_VECTOR(2 downto 0);
            result  : out STD_LOGIC_VECTOR(7 downto 0);
            z_flag  : out STD_LOGIC
        );
    end component;

    component Register_ACC_Z is
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            alu_res   : in  STD_LOGIC_VECTOR(7 downto 0);
            alu_z     : in  STD_LOGIC;
            acc_out   : out STD_LOGIC_VECTOR(7 downto 0);
            z_out     : out STD_LOGIC
        );
    end component;

    signal internal_pc : STD_LOGIC_VECTOR(3 downto 0);
    signal instr       : STD_LOGIC_VECTOR(11 downto 0);
    signal alu_op      : STD_LOGIC_VECTOR(2 downto 0);
    signal alu_result  : STD_LOGIC_VECTOR(7 downto 0);
    signal alu_z       : STD_LOGIC;
    signal current_acc : STD_LOGIC_VECTOR(7 downto 0);

begin

    PC_Unit: PC
        port map (
            clk    => CLK,
            reset  => RESET,
            pc_src => '0',
            target => "0000",
            pc_out => internal_pc
        );

    ROM_Unit: Program_ROM
        port map (
            addr  => internal_pc,
            instr => instr
        );

    Control_Unit_Inst: Control_Unit
        port map (
            opcode => instr(11 downto 8),
            alu_op => alu_op
        );

    ALU_Unit: ALU
        port map (
            acc     => current_acc,
            operand => instr(7 downto 0),
            alu_op  => alu_op,
            result  => alu_result,
            z_flag  => alu_z
        );

    ACC_Z_Reg: Register_ACC_Z
        port map (
            clk     => CLK,
            reset   => RESET,
            alu_res => alu_result,
            alu_z   => alu_z,
            acc_out => current_acc,
            z_out   => Z
        );

    Q      <= current_acc;
    PC_out <= internal_pc;

end Structural;