module Data_Path 
    #(parameter Data_Width =32)
    (
        output  wire    [Data_Width-1:0]    PC,
        output  wire    [Data_Width-1:0]    ALU_Out,
        output  wire    [Data_Width-1:0]    Write_Data,
        output  wire                        Zero_Flag,
        input   wire                        MemtoReg,ALUSrc,RegDst,RegWrite,Jump,PCSrc,
        input   wire    [2:0]               ALU_Control,
        input   wire    [Data_Width-1:0]    Instruction,
        input   wire    [Data_Width-1:0]    Read_Data,    
        input   wire                        clk,reset
);
        wire    [Data_Width-1:0]     offset_SignImm,offset_SignImm_shifted;
        wire    [Data_Width-1:0]     PC_plus4,PC_Branch,PC_MUX_Out,PC_Instr;
        wire    [Data_Width-1:0]     Register_File_Write_Data,SrcA,SrcB;
        wire    [$clog2(Data_Width)-1:0]     Write_Address;
        wire    [27:0]  shift_in_Instr,Instruction_28_shifted;
        assign shift_in_Instr={{2{1'b0}},Instruction[25:0]};

    Sign_Ext    Sign_Extension ( .Ext_in(Instruction[15:0]), .Ext_out(offset_SignImm) );

    Shift_Left_Twice    Shift_left_twice_SignImm (.shift_in(offset_SignImm),.shift_out(offset_SignImm_shifted));

    adder   Adder_PCplus4 (.A(PC), .B(32'd4), .Result(PC_plus4) );

    adder   Adder_Branch (.A(offset_SignImm_shifted), .B(PC_plus4), .Result(PC_Branch) );

    Mux21 Mux_R_Branch_Instr (.A(PC_plus4),.B(PC_Branch),.sel(PCSrc),.Mux_out(PC_MUX_Out));

    Shift_Left_Twice #(.Data_Width(28))   Shift_left_twice_Instr (.shift_in(shift_in_Instr),.shift_out(Instruction_28_shifted));

    Mux21 Mux_Jump_Instr (.A(PC_MUX_Out),.B({PC_plus4[31:28],Instruction_28_shifted}),.sel(Jump),.Mux_out(PC_Instr));

    Mux21 Mux_MemtoReg (.A(ALU_Out),.B(Read_Data),.sel(MemtoReg),.Mux_out(Register_File_Write_Data));

    Program_Counter ProgramCounter (.PC(PC),.PC_Instr(PC_Instr),.clk(clk),.reset(reset));

    Mux21 #(.Data_Width(5)) Mux_RegDst (.A(Instruction[20:16]),.B(Instruction[15:11]),.sel(RegDst),.Mux_out(Write_Address));
    
    Register_File RegFile (
    .Read1(SrcA), .Read2(Write_Data),
    .Write_Data(Register_File_Write_Data), .WriteAddress(Write_Address),
    .ReadAdress1(Instruction[25:21]), .ReadAdress2(Instruction[20:16]),
    .clk(clk),.reset(reset),.Write_Enable(RegWrite)    );

    Mux21 Mux_ALU (.A(Write_Data),.B(offset_SignImm),.sel(ALUSrc),.Mux_out(SrcB));

    ALU Alu (.A(SrcA),.B(SrcB),.Alu_Contorl(ALU_Control),.ALU_Result(ALU_Out),.Zero_Flag(Zero_Flag) );


endmodule