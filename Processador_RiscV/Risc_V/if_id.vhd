--	Registradores de interface do RISC-V
-- Thiago Cardoso e Thiago Gomes


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity if_id is

generic(WSIZE : natural := 32);      
    
port(
	clk : in std_logic;
	
	pc_in, instr_in : in std_logic_vector(WSIZE -1 downto 0);
	pc_out, instr_out : out std_logic_vector(WSIZE -1 downto 0);
	rs1_out, rs2_out, rd_out : out std_logic_vector(4 downto 0);
	ula_instr : out std_logic_vector(3 downto 0)
);
end if_id;

architecture main of if_id is

begin

process(clk) begin

	if rising_edge(clk) then
		pc_out <= pc_in;
		instr_out <= instr_in;
		rs1_out <= instr_in(19 downto 15);
		rs2_out <= instr_in(24 downto 20);
		rd_out <= instr_in(11 downto 7);
		ula_instr <= instr_in(30) & instr_in(14 downto 12);
	end if;

end process;

end main;