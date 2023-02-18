library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux is 
	generic (WSIZE : natural := 32);
	port (
		a, b, c, d : in std_logic_vector(WSIZE-1 downto 0);
		ctrl0, ctrl1 : in std_logic;
		z : out std_logic_vector(WSIZE-1 downto 0));
end mux;

architecture main of mux is

begin

	z <= 	a when (ctrl1 = '0' and ctrl0 = '0'),
			b when (ctrl1 = '0' and ctrl0 = '1'),
			c when (ctrl1 = '1' and ctrl0 = '0'),
			d when (ctrl1 = '1' and ctrl0 = '1'),
			"XXXX" when others;
.
end main;