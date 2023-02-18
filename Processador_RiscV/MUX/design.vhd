library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux is 
	generic (WSIZE : natural := 32);
	port (
		a, b : in std_logic_vector(WSIZE-1 downto 0);
        ctrl : in std_logic;
        z : out std_logic_vector(WSIZE-1 downto 0));
end mux;

architecture main of mux is

begin

	z <= b when ctrl = '1' else a;

end main;