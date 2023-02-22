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

mem: Code_Mem_RV port map(
	clk => clk,
	addr =>	PC,
	data_out => if_instr
);

mem: Data_Mem_RV port map(
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

end main;