module ALU
    #(parameter Data_Width =32)
    (
    output  reg    [Data_Width-1:0]    ALU_Result,
    output  wire                       Zero_Flag,
    input   wire    [Data_Width-1:0]   A,B,
    input   wire    [2:0]              Alu_Contorl
);

always @(*)
begin
    case (Alu_Contorl)
        3'b000: ALU_Result= A & B;
        3'b001: ALU_Result= A | B;
        3'b010: ALU_Result= A + B;
        3'b100: ALU_Result= A - B;
        3'b101: ALU_Result= A * B;
        3'b110: ALU_Result= (A < B)? { (Data_Width) {1'b1} }: { (Data_Width) {1'b0} };
        default: ALU_Result= { (Data_Width) {1'b0} } ;
    endcase
end


assign Zero_Flag= (ALU_Result==0)? 1'b1 : 1'b0;

endmodule