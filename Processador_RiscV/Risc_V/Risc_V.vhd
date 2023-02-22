--	Projeto do RISC-V
-- Thiago Cardoso e Thiago Gomes


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RiscV is

generic(WSIZE : natural := 32);      
    
port( 
		
);
end RiscV;

architecture main of RiscV is

-- Declaração dos módulos

component ULA_RiscV is
	port(
		opcode: in std_logic_vector(3 downto 0);
  		A, B : in std_logic_vector(WSIZE -1 downto 0);
 	 	Z : out std_logic_vector(WSIZE -1 downto 0);
		zero : out std_logic
	);
end component;

component XREGS is
	port(
		clk, wren, rst	:	in		std_logic;
		rs1, rs2, rd	:	in		std_logic_vector(4 downto 0);
		data				:	in		std_logic_vector(WSIZE-1 downto 0);
		ro1, ro2			:	out	std_logic_vector(WSIZE-1 downto 0)
	);
end component;

component genImm32 is
	port (
		instr : in std_logic_vector(31 downto 0);
		imm32 : out signed(31 downto 0)
	);
end component;

component Code_Mem_RV is
	port (
		clk 	: in	std_logic;
		addr 	: in	std_logic_vector(31 downto 0);
		data_in  : in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end component;

component Data_Mem_RV is
	port (
		clk 	: in	std_logic;
		we 		: in	std_logic;
		addr 	: in	std_logic_vector(31 downto 0);
		data_in  : in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end component;

component Control is
	port (
		instr  : in std_logic_vector(31 downto 0);
		ALUOp  : out std_logic_vector(1 downto 0);
		ALUSrc, Branch, MemRead, MemWrite, RegWrite, Mem2Reg: out std_logic
	);
end component;

component if_id is     
	port(
		clk : in std_logic;
		
		pc_in, instr_in : in std_logic_vector(WSIZE -1 downto 0);
		pc_out, instr_out : out std_logic_vector(WSIZE -1 downto 0)
	);
end component;

component id_ex is
	port(
		clk : in std_logic;
		
		wb_in, m_in, ex_in, branch_in : in std_logic;
		wb_out, m_out, ex_out, branch_out : out std_logic;
		rd_in : in std_logic_vector(4 downto 0);
		rd_out : out std_logic_vector(4 downto 0);
		rs1_in, rs2_in, pc_in, imm_in : in std_logic_vector(WSIZE -1 downto 0);
		rs1_out, rs2_out, pc_out, imm_out : out std_logic_vector(WSIZE -1 downto 0);
	);
end component;

component ex_mem is
	port(
		clk : in std_logic;
		
		wb_in, m_in, branch_in, zero_in : in std_logic;
		wb_out, m_out, branch_out, zero_out : out std_logic;
		rd_in : in std_logic_vector(4 downto 0);
		rd_out : out std_logic_vector(4 downto 0);
		rs2_in, pc_in, ula_in : in std_logic_vector(WSIZE -1 downto 0);
		rs2_out, pc_out, ula_out : out std_logic_vector(WSIZE -1 downto 0);
	);
end component;

component mem_wb is    
	port(
		clk : in std_logic;
		
		wb_in : in std_logic;
		wb_out : out std_logic;
		rd_in : in std_logic_vector(4 downto 0);
		rd_out : out std_logic_vector(4 downto 0);
		ula_in, mem_data_in : in std_logic_vector(WSIZE -1 downto 0);
		ula_out, mem_data_out : out std_logic_vector(WSIZE -1 downto 0);
	);
end component;

-- Ligação entre módulos
begin

signal clk, x_we, x_rst, zero, m_we : std_logic;
signal ula_command : std_logic_vector(3 downto 0);
signal rs1, rs2, rd : std_logic_vector(4 downto 0);
signal PC, mem_addr : std_logic_vector(7 downto 0);
signal xreg_out1, xreg_out2, xreg_in, ula_in1, ula_in2, ula_out : std_logic_vector(WSIZE-1 downto 0);
signal id_instr, if_instr, mem_out, mem_in: std_logic_vector(WSIZE-1 downto 0);

xreg: XREGS port map(
	clk => clk,
	wren => x_we,
	rst => x_rst,
	rs1 => rs1,
	rs2 => rs2,
	rd => rd,
	data => xreg_in,
	ro1 => xreg_out1,
	ro2 => xreg_out2
);

ula: ULA_RiscV port map(
	opcode => ula_command,
	A => ula_in1,
	B => ula_in2,
	Z => ula_out,
	zero => zero
);

imm: genImm32 port map(
	instr => id_instr,
	imm32 => imm32
);

code_mem: Code_Mem_RV port map(
	clk => clk,
	addr =>	PC,
	data_out => if_instr
);

data_mem: Data_Mem_RV port map(
	clk => clk,
	we => m_we,
	addr =>	mem_addr,
	data_in  => mem_in,
	data_out => mem_out
);

control: Control port map(
	instr  => id_instr,
	ALUOp  => id_AluOp,
	ALUSrc => id_ALUSrc,
	Branch => id_Branch,
	MemRead => id_MemRead,
	MemWrite => id_MemWrite,
	RegWrite => id_RegWrite, 
	Mem2Reg => id_Mem2Reg
);

if_id: if_id port map(
		clk => clk,		
		pc_in => pc_if,
		instr_in => intr_if,
		pc_out => id_pc,
		instr_out => id_instr
	);

id_ex id_ex port map(
		clk => clk,		
		wb_in => wb_id,
		m_in => m_id,
		ex_in => ex_id,
		branch_in => branch_id,
		wb_out => ex_wb,
		m_out => ex_wb,
		ex_out => ex_ex,
		branch_out => ex_branch,
		rd_in => rd_id,
		rd_out => ex_rd,
		rs1_in => rs1_id,
		rs2_in => rs2_id,
		pc_in => pc_id,
		imm_in => imm_id,
		rs1_out => ex_rs1,
		rs2_out => ex_rs2,
		pc_out => ex_pc,
		imm_out => ex_imm
	);

component ex_mem is
	port(
		clk => clk,		
		wb_in => ex_wb,
		m_in => ex_m,
		branch_in => ex_branch,
		zero_in => zero_ex,
		wb_out => mem_wb,
		m_out => mem_m,
		branch_out => mem_branch,
		zero_out => mem_zero,
		rd_in => ex_rd,
		rd_out => mem_rd,
		rs2_in => ex_rs2,
		pc_in => pc_ex,
		ula_in => ula_ex,
		rs2_out => mem_rs2,
		pc_out => mem_pc,
		ula_out => mem_ula
	);
end component;

component mem_wb is    
	port(
		clk => clk,		
		wb_in => mem_wb,
		wb_out => wb_wb,
		rd_in => mem_rd,
		rd_out => wb_rd,
		ula_in => mem_ula,
		memo_data_in => memo_data_mem,
		ula_out => wb_ula,
		memo_data_out => wb_memo_data
	);

end main;