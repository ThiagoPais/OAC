library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench is
end entity testbench;

architecture sum of testbench is

component sum is
	port (
      a : in std_logic_vector(7 downto 0);
      z : out std_logic_vector(7 downto 0));
end component sum;

signal a, z : std_logic_vector(7 downto 0);

begin

DUT: sum
	port map(
    a => a,
    z => z);
    
DRIVE: process begin
  a <= x"01";
  wait for 5 ns;

  a <= x"02";
  wait for 5 ns;

  a <= x"02";
  wait for 5 ns;
wait;
end process;

end architecture sum;