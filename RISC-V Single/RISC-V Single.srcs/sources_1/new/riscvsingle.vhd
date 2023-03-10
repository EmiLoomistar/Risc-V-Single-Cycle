----------------------------------------------------------------------------------
-- Company: Sunflower
-- Engineer: Emi Garo
-- 
-- Create Date: 12/26/2022 02:02:26 PM
-- Design Name: Ris-V Single Cycle Processor
-- Module Name: riscvsingle - Behavioral
-- Project Name: Best name
-- Target Devices: Pynq-Z2
-- Tool Versions: 1.0
-- Description: This is just practice and having fun!
-- 
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: ola
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity riscvsingle is
    port(clk, reset:            in  STD_LOGIC; 
        PC:                     out STD_LOGIC_VECTOR(31 downto 0);
        Instr:                  in  STD_LOGIC_VECTOR(31 downto 0);
        MemWrite:               out STD_LOGIC;
        ALUResult, WriteData:   out STD_LOGIC_VECTOR(31 downto 0);
        ReadData:               in  STD_LOGIC_VECTOR(31 downto 0)
        );
end riscvsingle;

architecture struct of riscvsingle is
    component controller
        port(op:            in  STD_LOGIC_VECTOR(6 downto 0);
            funct3:         in  STD_LOGIC_VECTOR(2 downto 0);
            funct7b5, Zero: in  STD_LOGIC;
            ResultSrc:      out STD_LOGIC_VECTOR(1 downto 0);
            MemWrite:       out STD_LOGIC;
            PCSrc, ALUSrc:  out STD_LOGIC;
            RegWrite, Jump: out STD_LOGIC;
            ImmSrc:         out STD_LOGIC_VECTOR(1 downto 0);
            ALUControl:     out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    component datapath
        port(clk, reset:            in  STD_LOGIC;
            ResultSrc:              in  STD_LOGIC_VECTOR(1 downto 0);
            PCSrc, ALUSrc:          in  STD_LOGIC;
            RegWrite:               in  STD_LOGIC;
            ImmSrc:                 in  STD_LOGIC_VECTOR(1 downto 0);
            ALUControl:             in  STD_LOGIC_VECTOR(2 downto 0);
            Zero:                   out STD_LOGIC;
            PC:                     out STD_LOGIC_VECTOR(31 downto 0);
            Instr:                  in  STD_LOGIC_VECTOR(31 downto 0);
            ALUResult, WriteData:   out STD_LOGIC_VECTOR(31 downto 0);
            ReadData:               in  STD_LOGIC_VECTOR(31 downto 0));
    end component;

    signal ALUSrc, RegWrite, Jump, Zero, PCSrc: STD_LOGIC;
    signal ResultSrc, immSrc: STD_LOGIC_VECTOR(1 downto 0);
    signal ALUControl: STD_LOGIC_VECTOR(2 downto 0);
begin

    c: controller port map(Instr(6 downto 0), Instr(14 downto 12),
                            Instr(30), Zero, ResultSrc, MemWrite,
                            PCSrc, ALUSrc, RegWrite, Jump, 
                            ImmSrc, ALUControl);
                            
    dp: datapath port map(clk, reset, ResultSrc, PCSrc, ALUSrc,
                        RegWrite, ImmSrc, ALUControl, Zero,
                        PC, Instr, ALUResult, WriteData,
                        ReadData); 

end;
