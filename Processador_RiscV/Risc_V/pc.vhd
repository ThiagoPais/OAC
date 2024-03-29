--	Registradores de interface do RISC-V
-- Thiago Cardoso e Thiago Gomes


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc is

generic(WSIZE : natural := 32);      
    
port(
	clk : in std_logic;
	
	pc_in : in std_logic_vector(WSIZE -1 downto 0);
	pc_out : out std_logic_vector(WSIZE -1 downto 0)
);
end pc;

architecture main of pc is

begin

process(clk) begin

	if rising_edge(clk) then
		pc_out <= pc_in;
	end if;

end process;

end main;