library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity TB_ULA_RiscV is
	generic(WSIZE : natural := 32);
end entity;

architecture test of TB_ULA_RiscV is

component ULA_RiscV is
	port( 
		opcode: in std_logic_vector(3 downto 0);
  		A,B : in std_logic_vector(WSIZE -1 downto 0);
 	 	Z : out std_logic_vector(WSIZE -1 downto 0);
		zero : out std_logic
);
end component;


signal opcode: std_logic_vector(3 downto 0);
signal A, B: std_logic_vector(WSIZE -1 downto 0);
signal Z: std_logic_vector(WSIZE -1 downto 0);


begin

dut: ULA_RiscV port map(
		opcode => opcode,
      A => A,
  		B => B,
  		Z => Z
);
 
drive: process begin
	--Testa Soma
	opcode <= "0000";
    A <= x"00000003";
    B <= x"00000004";
    wait for 5 ns;
    
	 assert Z = x"00000007" report "Soma Incorreta" severity error;
    wait for 5 ns;
    
    --Testa Subtracao
    opcode <= "0001";
    A <= x"00000002";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = std_logic_vector(signed(A) - signed(B)) report "Subtracao Incorreta" severity error;
    wait for 5 ns;
    
    --Testa AND
    opcode <= "0010";
    A <= x"00000002";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = (A AND B) report "AND Incorreta" severity error;
    wait for 5 ns;
    
    --Testa OR
    opcode <= "0011";
    A <= x"00000002";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = (A OR B) report "OR Incorreta" severity error;
    wait for 5 ns;
    
    --Testa XOR
    opcode <= "0100";
    A <= x"00000002";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = (A XOR B) report "XOR Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SLLA
    opcode <= "0101";
    A <= x"00000001";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = x"00000008" report "SLLA Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SRLA
    opcode <= "0110";
    A <= x"80000000";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = x"10000000" report "SRLA Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SRA
    opcode <= "0111";
    A <= x"80000000";
    B <= x"00000003";
    wait for 5 ns;
    assert Z = x"F0000000" report "SRLA Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SLT
    opcode <= "1000";
    A <= x"F0000000";
    B <= x"00000010";
    wait for 5 ns;
    assert Z = x"00000001" report "SLT Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SLTU
    opcode <= "1001";
    A <= x"F0000000";
    B <= x"00000010";
    wait for 5 ns;
    assert Z = x"00000000" report "SLTU Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SGE
    opcode <= "1010";
    A <= x"F0000000";
    B <= x"00000010";
    wait for 5 ns;
    assert Z = x"00000000" report "SGE Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SGEU
    opcode <= "1011";
    A <= x"F0000000";
    B <= x"00000010";
    wait for 5 ns;
    assert Z = x"00000001" report "SGEU Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SEQ
    opcode <= "1100";
    A <= x"80000000";
    B <= x"80000000";
    wait for 5 ns;
    assert Z = x"00000001" report "SEQ Incorreta" severity error;
    wait for 5 ns;
    
    --Testa SNE
    opcode <= "1101";
    A <= x"00001000";
    B <= x"80000000";
    wait for 5 ns;
    assert Z = x"00000001" report "SNE Incorreta" severity error;
    wait for 5 ns;
    
  wait;  
end process;

end test;