//////////////////////////////////////////////////////////////
////The control unit computes the control signals based on////
////the opcode and function fields of the instruction. It ////
////consists of a Main Decoder & ALU Decoder. ControlUnit ////
////Outputs control The flow through the DataPath.        ////
//////////////////////////////////////////////////////////////


module Controller (
    output    reg    [2:0]      ALU_Control,
    output    reg               MemtoReg,MemWrite,PCSrc,ALUSrc,RegDst,RegWrite,Jump,  
    input     wire    [5:0]     Function,
    input     wire    [5:0]     OP_Code,
    input     wire              Zero_Flag
);

reg     [1:0]   ALU_OP;
reg             Branch; 

always@(*)
begin
    PCSrc=Branch&Zero_Flag;
end

localparam Load_Word = 6'b100011;
localparam Store_Word = 6'b101011;
localparam R_Type = 6'b000000;
localparam addImmediate = 6'b001000;
localparam branchIfEqual = 6'b000100;
localparam jump_inst = 6'b000010;
localparam ADD= 6'b100000;
localparam SLT=6'b101010;
localparam SUB=6'b100010;
localparam MUL=6'b011100;
localparam AND=6'b100100;
localparam OR=6'b100101;

always@(*)
begin
    MemtoReg=1'b0;
    MemWrite=1'b0;
    Branch=1'b0;
    ALUSrc=1'b0;
    RegDst=1'b0;
    RegWrite=1'b0;
    Jump=1'b0;
    ALU_OP=1'b0;

    case(OP_Code) 
    Load_Word : begin RegWrite=1'b1; ALUSrc=1'b1; MemtoReg=1'b1; end
    
    Store_Word : begin MemWrite=1'b1; ALUSrc=1'b1; MemtoReg=1'b1; end
    
    addImmediate : begin RegWrite=1'b1; ALUSrc=1'b1; end
    
    jump_inst : begin Jump=1'b1; end
    
    branchIfEqual : begin Branch=1'b1; ALU_OP=2'b01; end
    
    R_Type : begin RegWrite=1'b1; RegDst=1'b1; ALU_OP=2'b10; end
    
    default : begin
            MemtoReg=1'b0;
            MemWrite=1'b0;
            Branch=1'b0;
            ALUSrc=1'b0;
            RegDst=1'b0;
            RegWrite=1'b0;
            Jump=1'b0;
            ALU_OP=1'b0;
                end
    endcase
end


always@(*) begin
    case (ALU_OP)
    2'b00 : ALU_Control = 3'b010;
    2'b01 : ALU_Control = 3'b100;
    2'b10 :
   begin
       case (Function)
        ADD : ALU_Control= 3'b010;
        SUB : ALU_Control= 3'b100;
        SLT : ALU_Control= 3'b110;
        MUL : ALU_Control= 3'b101;
        AND : ALU_Control= 3'b000;
        OR  : ALU_Control= 3'b001;
       endcase
   end
   default : ALU_Control=3'b010; 
    endcase
end
   
endmodule