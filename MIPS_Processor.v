//////////////////////////////////////////////
//MIPS Processor top module that integrates///
//the Datapath, Controller, DataMemory and ///
//Instruction Memory. It outputs test_value///
/////and takes clk and reset as inputs////////
//////////////////////////////////////////////

module MIPS_Processor 
    #(parameter Data_Width =32)
    (
        output  wire    [(Data_Width/2)-1:0]   test_value,
        input   wire                        clk,reset
);

        wire Zero_Flag,MemtoReg,ALUSrc,RegDst,RegWrite,Jump,PCSrc,MemWrite;
        wire    [2:0]   ALU_Control;
        wire    [Data_Width-1:0]    ALU_Out,Write_Data,Read_Data,PC,Instruction;

Data_Path DataPath (
                .PC(PC),.ALU_Out(ALU_Out),.Write_Data(Write_Data),.Zero_Flag(Zero_Flag), .ALU_Control(ALU_Control),
                .Instruction(Instruction),.Read_Data(Read_Data),.clk(clk),.reset(reset),.ALUSrc(ALUSrc),.PCSrc(PCSrc),
                .MemtoReg(MemtoReg),.RegDst(RegDst),.RegWrite(RegWrite),.Jump(Jump)

                    );


Controller CtrlUnit (
                .ALU_Control(ALU_Control),.MemtoReg(MemtoReg),.RegDst(RegDst),.RegWrite(RegWrite),
                .Jump(Jump),. MemWrite(MemWrite),.ALUSrc(ALUSrc),.Zero_Flag(Zero_Flag),
                .Function(Instruction[5:0]),.OP_Code(Instruction[31:26]),.PCSrc(PCSrc)
                        );


Data_Memory DataMem(.Read_Data(Read_Data),.Write_Data(Write_Data),.Address(ALU_Out),
                    .Write_Enable(MemWrite),.clk(clk),.reset(reset),.test_value(test_value)   );


Instruction_Memory InstrMem (.Instr(Instruction),.Address(PC) );

endmodule