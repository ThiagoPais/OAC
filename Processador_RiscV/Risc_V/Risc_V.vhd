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
		addr 	: in	std_logic_vector(7 downto 0);
		data_in  : in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end component;

component Data_Mem_RV is
	port (
		clk 	: in	std_logic;
		we 		: in	std_logic;
		addr 	: in	std_logic_vector(7 downto 0);
		data_in  : in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end component;

begin

xreg: XREGS port map(
	clk => clk,
	wren => x_we,
	rst => x_rst	:	in		std_logic;
	rs1, rs2, rd	:	in		std_logic_vector(4 downto 0);
	data				:	in		std_logic_vector(WSIZE-1 downto 0);
	ro1, ro2
);

end main;