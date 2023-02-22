library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Control is
	port (
			instr  : in std_logic_vector(31 downto 0);
			ALUOp  : out std_logic_vector(1 downto 0);
			ALUSrc, Branch, MemRead, MemWrite, RegWrite, Mem2Reg, AUIPc: out std_logic);
            
end Control;

architecture behavioral of Control is
	signal opcode : std_logic_vector(7 downto 0);

begin 
	opcode <= '0' & instr(6 downto 0);
    
	process (opcode) begin
    
	case opcode is
		when x"33" => 
			ALUOp  <= "10";
			ALUSrc <= '0';
			Branch <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			RegWrite <= '1';
			Mem2Reg <= '0';
			AUIPc <= '0';
            
		when x"03" | x"13" | x"67" =>
			ALUOp  <= "00";
			ALUSrc <= '1';
			Branch <= '0';
			MemRead <= '1';
			MemWrite <= '0';
			RegWrite <= '1';
			Mem2Reg <= '1';
			AUIPc <= '0';
            
		when x"23" =>
			ALUOp  <= "00";
			ALUSrc <= '1';
			Branch <= '0';
			MemRead <= '0';
			MemWrite <= '1';
			RegWrite <= '0';
			AUIPc <= '0';
            
		when x"63" =>
			ALUOp  <= "01";
			ALUSrc <= '0';
			Branch <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			RegWrite <= '0';
			AUIPc <= '0';
	  
		when others => 
			ALUOp  <= "00";
			ALUSrc <= '0';
			Branch <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			RegWrite <= '0';
			Mem2Reg <= '0';
			AUIPc <= '0';
      end case;
    end process;
end;