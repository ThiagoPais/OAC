--	Projeto memória do RISC-V - Testbench
-- Thiago Cardoso
--	160146372

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity TB_Mem_RV is
end TB_Mem_RV;

architecture test of TB_Mem_RV is

component mem_rv is 
	port (
		clk		: in	std_logic;
		we 		: in	std_logic;
		addr		: in	std_logic_vector(7 downto 0);
		data_in  : in	std_logic_vector(31 downto 0);
		data_out : out	std_logic_vector(31 downto 0)
	);
end component;

signal clk, we				:	std_logic;
signal addr					:	std_logic_vector(7 downto 0);
signal data_in, data_out	:	std_logic_vector(31 downto 0);

begin
	DUT: mem_rv port map(clk => clk, we => we, addr => addr, data_in => data_in, data_out => data_out);

process
	begin
		for i in 0 to 255 loop
			clk		<= '0';
			we			<=	'0';
			addr		<= std_logic_vector(to_unsigned(i,8));
			data_in	<= std_logic_vector(to_unsigned(i,30)) & "00";
			--report to_string(data_out);
			wait for 1 ns;
			
			clk		<=	'1';
			we			<=	'1';
			wait for 1 ns;
		end loop;
	end process;
end test;