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
		ALUSrc, Branch, MemRead, MemWrite, RegWrite, Mem2Reg, AUIPc: out std_logic
	);
end component;

component if_id is     
	port(
		clk : in std_logic;
		
		pc_in, instr_in : in std_logic_vector(WSIZE -1 downto 0);
		pc_out, instr_out : out std_logic_vector(WSIZE -1 downto 0);
		rs1_out, rs2_out, rd_out : out std_logic_vector(4 downto 0);
		ula_instr : out std_logic_vector(3 downto 0)
	);
end component;

component id_ex is
	port(
		clk : in std_logic;
		
		ALUSrc_in, wb_in, memread_in, memwrite_in, branch_in : in std_logic;
	ALUSrc_out, wb_out, memread_out, memwrite_out, branch_out, funct7 : out std_logic;	
	ALUOp_in : in std_logic_vector(1 downto 0);
	ALUOp_out : out std_logic_vector(1 downto 0);
	rd_in : in std_logic_vector(4 downto 0);
	rd_out : out std_logic_vector(4 downto 0);
	rs1_in, rs2_in, pc_in, imm_in : in std_logic_vector(WSIZE -1 downto 0);
	rs1_out, rs2_out, pc_out, imm_out : out std_logic_vector(WSIZE -1 downto 0);
	ula_instr_in : in std_logic_vector(3 downto 0);
	funct3 : out std_logic_vector(2 downto 0);
	);
end component;

component ex_mem is
	port(
		clk : in std_logic;
		
		wb_in, m_in, branch_in, zero_in, memread_in, memwrite_in : in std_logic;
		wb_out, m_out, branch_out, zero_out, memread_out, memwrite_out : out std_logic;
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

component add_pc is

	port(
		A : in std_logic_vector(31 downto 0);
		Z : out std_logic_vector(31 downto 0)
	);

end component;

component my_and is

	port(
		A : in std_logic;
		B : in std_logic;
		Y : out std_logic
	);

end component;

component add_sum is

	port(
		pc_in, imm : in std_logic_vector(31 downto 0);
		pc_out : out std_logic_vector(31 downto 0)
	);

end component;

component mux is 
	port (
		a, b : in std_logic_vector(WSIZE-1 downto 0);
		ctrl: in std_logic;
		z : out std_logic_vector(WSIZE-1 downto 0)
	);
end component;

component pc is
	port(
		clk : in std_logic;
		
		pc_in : in std_logic_vector(WSIZE -1 downto 0);
		pc_out : out std_logic_vector(WSIZE -1 downto 0)
	);
end component;

component Control_ALU is
	port (
		ALUOp : in std_logic_vector(1 downto 0);
		funct7 : in std_logic;
		auipcIn : in std_logic;
		funct3 : in std_logic_vector(2 downto 0);
		opOut : out std_logic_vector(3 downto 0)
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

x_rst <= 0;

xreg: XREGS port map(
	clk => clk,
	wren => RegWrite,
	rst => x_rst,
	rs1 => id_rs1,
	rs2 => id_rs2,
	rd => WriteReg,
	data => WriteData,
	ro1 => rs1_id,
	ro2 => rs2_id
);

ula: ULA_RiscV port map(
	opcode => ula_command,
	A => ula_in1,
	B => ula_in2,
	Z => ula_ex,
	zero => zero_ex
);

imm: genImm32 port map(
	instr => id_instr,
	imm32 => imm_id
);

code_mem: Code_Mem_RV port map(
	clk => clk,
	addr =>	pc_out,
	data_out => instr_if
);

data_mem: Data_Mem_RV port map(
	clk => clk,
	we => MemWrite,
	addr => mem_ula,
	data_in => mem_rs2,
	data_out => memo_data_mem
);

control: Control port map(
	instr  => id_instr,
	ALUOp  => ALUOp_id,
	ALUSrc => ALUSrc_id,
	Branch => branch_id,
	MemRead => memread_id,
	MemWrite => memwrite_id,
	RegWrite => wb_id, 
	Mem2Reg => open,
	AUIPc => id_auipc
);

ula_ctrl: Control_ALU port map(
	ALUOp => ex_ALUOp,
	funct7 => ex_funct7,
	auipcIn => ex_auipc,
	funct3 => ex_funct3,
	opOut => ula_command
);

if_id: if_id port map(
	clk => clk,		
	pc_in => pc_out,
	instr_in => intr_if,
	pc_out => id_pc,
	instr_out => id_instr
	rd_out => rd_id,
	ula_instr => ula_instr_id,
	rs1_out => id_rs1,
	rs2_out => id_rs2
);

id_ex: id_ex port map(
	clk => clk,		
	wb_in => wb_id,
	branch_in => branch_id,
	wb_out => ex_wb,
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
	imm_out => ex_imm.
	ula_instr_in => ula_instr_id,
	ALUOp_in => ALUOp_id,
	ALUOp_out => ex_ALUOp,
	ALUSrc_in => ALUSrc_id,
	ALUSrc_out => ex_ALUSrc,
	memread_in => memread_id,
	memread_out => ex_memread,
	memwrite_in => memwrite_id,
	memwrite_out => ex_memwrite,
	funct7 => ex_funct7,
	funct3 => ex_funct3,
	auipc_in => auipc_id,
	auipc_out => ex_auipc
);

ex_mem: ex_mem port map(
	clk => clk,		
	wb_in => ex_wb,
	branch_in => ex_branch,
	zero_in => zero_ex,
	wb_out => mem_wb,
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
	memread_in => ex_memread,
	memread_out => mem_memread,
	memwrite_in => ex_memwrite,
	memwrite_out => mem_memwrite
);

mem_wb: mem_wb port map(
	clk => clk,		
	wb_in => mem_wb,
	wb_out => Mem2Reg,
	rd_in => mem_rd,
	rd_out => WriteReg,
	ula_in => mem_ula,
	memo_data_in => memo_data_mem,
	ula_out => wb_ula,
	memo_data_out => wb_memo_data
	memread_in => mem_memread,
	memread_out => Mem2Reg,
);
	
add_pc: add_pc port map(
	A => pc_if,
	Z => pc_4
);

branch_and: my_and port map(
	A => mem_branch,
	B => mem_zero,
	Y => PCSrc
);

add_sum: add_sum port map(
	pc_in => ex_pc,
	imm => ex_imm,
	pc_out => pc_ex
);

pc port map(
	clk => clk,	
	pc_in => pc_in;
	pc_out => pc_out
);

mux_pc: mux port map(
	a => pc_4,
	b => mem_pc,
	ctrl => PCSrc,
	z => pc_in
);

mux_ula1: mux port map(
	a => ex_rs2,
	b => ex_imm,
	ctrl => ex_ALUSrc,
	z => ula_in2
);

mux_ula2: mux port map(
	a => ex_rs1,
	b => ex_pc,
	ctrl => id_auipc,
	z => ula_in1
);

mux_wb: mux port map(
	a => wb_memo_data,
	b => wb_ula,
	ctrl => Mem2Reg,
	z => WriteData
);

end main;