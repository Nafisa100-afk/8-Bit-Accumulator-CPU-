library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_ROM is
    Port (
        addr  : in  STD_LOGIC_VECTOR(3 downto 0);
        instr : out STD_LOGIC_VECTOR(11 downto 0)
    );
end Program_ROM;

architecture Behavioral of Program_ROM is
    type rom_type is array (0 to 15) of STD_LOGIC_VECTOR(11 downto 0);
    -- ROM content for Set 3
    constant ROM : rom_type := (
        0  => x"180", -- LDI 0x80
        1  => x"900", -- SHR
        2  => x"310", -- SUB 0x10
        3  => x"20F", -- ADD 0x0F
        4  => x"63F", -- XOR 0x3F
        5  => x"207", -- ADD 0x07
        6  => x"900", -- SHR
        others => x"000" -- NOP
    );
begin
    instr <= ROM(to_integer(unsigned(addr)));
end Behavioral;