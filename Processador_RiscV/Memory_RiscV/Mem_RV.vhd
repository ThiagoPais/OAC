--	Projeto memória do RISC-V
-- Thiago Cardoso
--	160146372

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity Mem_RV is
	port (
		clk 	: in	std_logic;
		we 		: in	std_logic;
		addr 	: in	std_logic_vector(7 downto 0);
		data_in  : in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end entity;

architecture RTL of Mem_RV is

Type ram_type is array (0 to ram_depth - 1) of std_logic_vector(ram_width - 1 downto 0);

Type mem_type is array (0 to (2**addr'length)-1) of std_logic_vector(data_in'range);

signal read_addr: std_logic_vector(addr'range);

impure function init_mem return mem_type is
	file text_file	:	text open read_mode is "code.txt";
	file data_file	:	text open read_mode is "data.txt";
	
	variable text_line	:	line;
	variable text_word	:	std_logic_vector(data_in'range);
	variable memoria		:	mem_type;
	variable n				:	integer;

begin
	n	:=	0;
	while not endfile(text_file) loop
		readline(text_file, text_line);
		hread(text_line, text_word);
		memoria(n)	:=	text_word;
		n	:=	n+4;
	end loop;
	
	n	:=	128;
	while	n<4096	loop
		readline(data_file, text_line);
		hread(text_line, text_word);
		memoria(n)	:=	text_word;
		n	:=	n+4;
	end loop;
return memoria;
end;

signal mem: mem_type := init_mem;

begin
	process(clk) begin
		if rising_edge(clk)then
			if we = '1' and n > 127 then
				mem(to_integer(unsigned(addr))) <= data_in;
			end if;
		end if;
		read_addr <= addr;
	end process;
	
	dataout <= mem(to_integer(unsigned(read_addr)));

end architecture;