LIBRARY IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sum_imm is 
	port (
      a, b: in std_logic_vector(31 downto 0);
      z : out std_logic_vector(31 downto 0));
end sum_imm;

architecture main of sum_imm is

begin

	z <= a+b;

end main;