--	Registradores de interface do RISC-V
-- Thiago Cardoso e Thiago Gomes


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity id_ex is

generic(WSIZE : natural := 32);      
    
port(
	clk : in std_logic;
	
	wb_in, m_in, ex_in, branch_in : in std_logic;
	wb_out, m_out, ex_out, branch_out : out std_logic;
	rd_in : in std_logic_vector(4 downto 0);
	rd_out : out std_logic_vector(4 downto 0);
	rs1_in, rs2_in, pc_in, imm_in : in std_logic_vector(WSIZE -1 downto 0);
	rs1_out, rs2_out, pc_out, imm_out : out std_logic_vector(WSIZE -1 downto 0);
	
	
	--instr_in : in std_logic_vector(WSIZE -1 downto 0);
	--instr_out : out std_logic_vector(WSIZE -1 downto 0)
);
end id_ex;

architecture main of id_ex is

begin

process(clk) begin

	if rising_edge(clk) then
		wb_out <= wb_in
		m_out <= m_in
		ex_out <= ex_in
		branch_out <= branch_in
		rd_out <= rd_in
		rs1_out <= rs1_in
		rs2_out <= rs2_in
		pc_out <= pc_in
		imm_out <= imm_in
	end if;

end process;

end main;