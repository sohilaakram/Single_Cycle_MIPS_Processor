module Program_Counter
    #(parameter Data_Width=32)
    (
    output  reg     [Data_Width-1:0]   PC,
    input   wire    [Data_Width-1:0]   PC_Instr,                 
    input   wire                       clk,reset
);

    always@(posedge clk or negedge reset)
    begin
        if (!reset)
            PC<={ (Data_Width) {1'b0} };
        else 
            PC<=PC_Instr;
               
    end

endmodule