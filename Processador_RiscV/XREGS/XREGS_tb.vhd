--	Testbench do projeto do banco de registradores do RISC-V
-- Marcus Jesse A de Oliveira

library IEEE;
use	IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;

entity XREGS_tb is
end XREGS_tb;

architecture main of XREGS_tb is
component XREGS is
	port(
		clk, wren, rst	:	in		std_logic;
		rs1, rs2, rd	:	in		std_logic_vector(4 downto 0);
		data				:	in		std_logic_vector(31 downto 0);
		ro1, ro2			:	out	std_logic_vector(31 downto 0)
	);
end component;

signal clock, we, reset		:	std_logic;
signal r1in, r2in, destino	:	std_logic_vector(4 downto 0);
signal datas, r1out, r2out	:	std_logic_vector(31 downto 0);
signal final					:	std_logic	:=	'0';

begin
DUT: XREGS	port map (clk => clock, wren => we, rst => reset, rs1 => r1in, rs2 => r2in, rd => destino, data => datas, ro1 => r1out, ro2 => r2out);

process
	begin
		while final = '0' loop
			clock <= '0';
			wait for 5 ns;
			clock <= '1';
			wait for 5 ns;
		end loop;
	wait;
end process;

process
	begin
		r1in	<=	"00001";
		r2in	<=	"00010";
		
		we		<=	'0';		--nao escreve
		reset	<=	'1';
		wait for 10 ns;
		we		<=	'1';
		reset	<=	'0';
		wait for 10 ns;
		destino	<=	"000001";
		wait for 10 ns;
		
		datas	<=	"00000000000000000000000000000001";
		wait for 10 ns;
		destino	<=	"00010";
		wait for 10 ns;
		datas	<=	"00000100000000000000000000000000";
		wait for 10 ns;
		
		wait for 10 ns;
		
		assert(r1out = "00000000000000000000000000000001") report "Teste 1 falhou!" severity error;
		assert(r2out = "00000100000000000000000000000000")	report "Teste 2 falhou!" severity error;
		final	<=	'1';
	wait;
end process;
end main;		
		