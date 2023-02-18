library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench is
end entity testbench;

architecture sum_imm of testbench is

component sum_imm is
	port (
      a, b : in std_logic_vector(31 downto 0);
      z : out std_logic_vector(31 downto 0));
end component sum_imm;

signal a, b, z : std_logic_vector(31 downto 0);

begin

DUT: sum_imm
	port map(
    a => a,
    b => b,
    z => z);
    
DRIVE: process begin
  a <= x"00000001";
  b <= x"00000002";
  wait for 5 ns;

  a <= x"00000001";
  b <= x"00000006";
  wait for 5 ns;
  
  a <= x"00000002";
  b <= x"00000006";
  wait for 10 ns;
wait;
end process;

end architecture sum_imm;