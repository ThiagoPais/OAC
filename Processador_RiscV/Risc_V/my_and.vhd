library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity my_and is

port(
	A : in std_logic;
	B : in std_logic;
	Y : out std_logic
);

end my_and;


architecture basic of my_and is

begin

	Y <= (A and B);

end basic;