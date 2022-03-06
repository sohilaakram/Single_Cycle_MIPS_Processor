module Register_File
#(parameter Data_Width=32)
(
    output  reg [Data_Width-1:0]            Read1, Read2,
    input   wire [Data_Width-1:0]            Write_Data,
    input   wire [$clog2(Data_Width)-1:0]  ReadAdress1, ReadAdress2, WriteAddress,
    input   wire                             clk,reset,Write_Enable
);

integer i;
localparam Mem_Depth =100;
reg [Data_Width-1:0] MEM [0:Mem_Depth-1];


always@(posedge clk or negedge reset)
begin
    if (!reset)
    begin
        for (i=0;i<Mem_Depth;i=i+1)
            MEM[i]<={ (Data_Width) {1'b0} };
    end
    else if (Write_Enable) 
        MEM[WriteAddress]<=Write_Data;
    
end
    
always@(*)
begin
    Read1=MEM[ReadAdress1];
    Read2=MEM[ReadAdress2];
end    
endmodule