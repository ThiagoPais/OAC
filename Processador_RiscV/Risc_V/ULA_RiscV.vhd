library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity ULA_RV is
	generic (WSIZE : natural := 32);
	port (
		opcode : in std_logic_vector(3 downto 0);
		A, B : in std_logic_vector(WSIZE-1 downto 0);
		Z : out std_logic_vector(WSIZE-1 downto 0));
end ULA_RV;

architecture behavioral of ULA_RV is

	constant ADD_OP : std_logic_vector := "0000";
	constant SUB_OP : std_logic_vector := "0001";
	constant AND_OP : std_logic_vector := "0010";
	constant OR_OP : std_logic_vector := "0011";
	constant XOR_OP : std_logic_vector := "0100";
	constant SLL_OP : std_logic_vector := "0101";
	constant SRL_OP : std_logic_vector := "0110";
	constant SRA_OP : std_logic_vector := "0111";
	constant SLT_OP : std_logic_vector := "1000";
	constant SLTU_OP : std_logic_vector := "1001";
	constant SGE_OP : std_logic_vector := "1010";
	constant SGEU_OP : std_logic_vector := "1011";
	constant SEQ_OP : std_logic_vector := "1100";
	constant SNE_OP : std_logic_vector := "1101";
    constant LUI_AUIPC_OP: std_logic_vector := "1110";
    constant JAL_OP: std_logic_vector := "1111";
	
	signal a32 : std_logic_vector(31 downto 0);
    signal zero : std_logic;
begin
	Z <= a32;
    proc_ula: process (A, B, opcode, a32) begin
    	if (a32 = x"00000000") then zero <= '1'; else zero <= '0'; end if;
        case opcode is
        	when ADD_OP => a32 <= std_logic_vector(signed(A) + signed(B));
            when SUB_OP => a32 <= std_logic_vector(signed(A) - signed(B));
            when AND_OP => a32 <= A and B;
            when OR_OP => a32 <= A or B;
            when XOR_OP => a32 <= A xor B;
            when SLL_OP => a32 <= A sll to_integer(unsigned(B));
            when SRL_OP => a32 <= A srl to_integer(unsigned(B));
            when SRA_OP => a32 <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
            when SLT_OP => a32 <= x"00000001" when A < B else x"00000000";
            when SLTU_OP => a32 <= x"00000001" when unsigned(A) < unsigned(B) else x"00000000";
            when SGE_OP => a32 <= x"00000001" when A >= B else x"00000000";
            when SGEU_OP => a32 <= x"00000001" when unsigned(A) >= unsigned(B) else x"00000000";
            when SEQ_OP => a32 <= x"00000001" when A = B else x"00000000";
            when SNE_OP => a32 <= x"00000001" when A /= B else x"00000000";
            
            when LUI_AUIPC_OP => a32 <= std_logic_vector(unsigned(A) + shift_left(unsigned(B), 12));
            when JAL_OP => a32 <= std_logic_vector(unsigned(A) + 4);
            
            when others => a32 <= x"00000000";
        end case;
	end process;
end;