library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testbench is
end entity testbench;

architecture mux of testbench is

component mux is
  generic (WSIZE : natural := 32);
  port (
          a, b : in std_logic_vector(WSIZE-1 downto 0);
          ctrl : in std_logic;
          z : out std_logic_vector(WSIZE-1 downto 0));
end component mux;

signal a, b, z : std_logic_vector(31 downto 0);
signal ctrl : std_logic;

begin

DUT: mux
	port map(
    a => a,
    b => b,
    z => z,
    ctrl => ctrl);
    
DRIVE: process begin
  a <= x"00000001";
  b <= x"00000002";
  ctrl <= '0';
  wait for 5 ns;

  ctrl <= '1';
  wait for 5 ns;
  
  a <= x"00000001";
  b <= x"00000003";
  ctrl <= '1';
  wait for 10 ns;

wait;
end process;

end architecture mux;