-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
end entity testbench;

architecture BENCH of testbench is

component Control is
	port (
			instr  : in std_logic_vector(31 downto 0);
            ALUOp  : out std_logic_vector(1 downto 0);
            ALUSrc, Branch, MemRead, MemWrite, RegWrite, Mem2Reg: out std_logic);
end component Control;

signal instr : std_logic_vector(31 downto 0);
signal ALUOp : std_logic_vector(1 downto 0);
signal ALUSrc, Branch, MemRead, MemWrite, RegWrite, Mem2Reg: std_logic;

begin

Drive: process begin
  	
    instr <= x"00000000";  
    wait for 10 ns;
    
    instr <= x"000002b3";  
    wait for 10 ns;
    
    instr <= x"01002283";  
    wait for 10 ns;
    
    instr <= x"f9c00313";  
    wait for 10 ns;
    
    instr <= x"fff2c293";  
    wait for 10 ns;
    
    instr <= x"16200313";  
    wait for 10 ns;
    
    instr <= x"01800067";  
    wait for 10 ns;
    
    instr <= x"00002437";  
    wait for 10 ns;
    
    instr <= x"02542e23";  
    wait for 10 ns;
    
    instr <= x"fe5290e3";  
    wait for 10 ns;
    
    instr <= x"00c000ef";  
    wait for 10 ns;
    
    instr <= x"00000000";  
    wait for 10 ns;

wait;
end process;

DUT: Control
     	port map (
        	instr => instr,
   			ALUOp  => ALUOp,
        	ALUSrc => ALUSrc,
        	Branch => Branch,
        	MemRead => MemRead,
        	MemWrite => MemWrite,
        	RegWrite => RegWrite,
        	Mem2Reg => Mem2Reg);
        	

end architecture BENCH;