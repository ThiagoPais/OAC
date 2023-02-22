--	Testbench do Projeto do RISC-V
-- Thiago Cardoso e Thiago Gomes


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is

generic(WSIZE : natural := 32);

end testbench;

architecture test of testbench is

component Code_Mem_RV is
	port (
		clk 	: in	std_logic;
		addr 	: in	std_logic_vector(31 downto 0);
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
	
signal addr, data_in, data_out : std_logic_vector(31 downto 0);
signal clk, we : std_logic;

begin

	DUT: Code_Mem_RV port map(clk => clk, addr => addr, data_out => data_out);

	DUT1: Data_Mem_RV port map(clk => clk, addr => addr, data_out => data_out, we => we, data_in => data_in);
	
	process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;

	process
	begin
		wait for 5 ns;
		
		addr <= x"00000000";
		wait for 10 ns;
		
		addr <= x"00000004";
		wait for 10 ns;
		
		addr <= x"00000008";
		wait for 10 ns;
		
		addr <= x"00000000";
		wait for 10 ns;
		
		addr <= x"00000100";
		wait for 10 ns;
		
		addr <= x"00000010";
		wait for 10 ns;
		
		addr <= x"00000014";
		wait for 10 ns;
		
		addr <= x"00002000";
		wait for 10 ns;
		
		addr <= x"00000000";
		wait for 10 ns;
		
		addr <= x"00002005";
		wait for 10 ns;
		
		addr <= x"00000008";
		wait for 10 ns;
		
		addr <= x"00003000";
		wait for 10 ns;
		
		addr <= x"00000004";
		wait for 10 ns;
	end process;
	
end test;