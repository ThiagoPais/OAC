LIBRARY IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sum is 
	port (
      a : in std_logic_vector(7 downto 0);
      z : out std_logic_vector(7 downto 0));
end sum;

architecture main of sum is

begin

	z <= a+4;

end main;