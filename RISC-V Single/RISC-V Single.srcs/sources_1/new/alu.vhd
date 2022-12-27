library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity alu is
    port(a, b:          in  STD_LOGIC_VECTOR(31 downto 0);
         ALUControl:    in  STD_LOGIC_VECTOR(2 downto 0);
         ALUResult:     buffer STD_LOGIC_VECTOR(31 downto 0);
         Zero:          out STD_LOGIC);
end alu;

architecture Behavioral of alu is
    signal slt_result : STD_LOGIC_VECTOR(31 downto 0);
begin
    slt_result <= X"00000001" when (a < b) else X"00000000";

    process(ALUControl) begin
        case ALUControl is 
            when "000" => ALUResult <= a + b;
            when "001" => ALUResult <= a - b;
            when "010" => ALUResult <= a and b;
            when "011" => ALUResult <= a or b;
            when "101" => ALUResult <= slt_result;
            when others => ALUResult <= (others => '-'); --Unknown
        end case; 
    end process;

    Zero <= '1' when (ALUResult = X"00000000") else '0';
    
end Behavioral;
