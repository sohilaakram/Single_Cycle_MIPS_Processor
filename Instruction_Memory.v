module Instruction_Memory
#(parameter Data_Width=32)
(
    output  reg     [Data_Width-1:0]   Instr,
    input   wire    [Data_Width-1:0]   Address
);

localparam Data_Depth=100;
reg [Data_Width-1:0] ROM [0:Data_Depth-1];

initial 
begin
    $readmemh("Program 1_Machine Code.txt",ROM);
end

always @(*)
begin
    Instr=ROM[Address>>2];
end
    
endmodule