/////////////////////////////////////////////////////////////
////The data memory is a RAM that provides a store for   ////
////the CPU to load from and store to. The Data Memory   ////
////has one output read port and one input write port.   ////
////Reads are asynchronous while writes are synchronous  ////
////to the rising edge of the “clk” signal. The Word     ////
////width of the data memory is 32-bits to match the     ////
////datapath width. The data memory contains 100 entries. ///
/////////////////////////////////////////////////////////////

module Data_Memory 
#(parameter Data_Width=32)
(
    output  reg  [Data_Width-1:0]   Read_Data,
    output  reg  [(Data_Width/2)-1:0]   test_value,
    input   wire [Data_Width-1:0]   Write_Data,
    input   wire [Data_Width-1:0]            Address,
    input   wire                    clk,reset,Write_Enable
);
localparam Memory_Depth =100;
reg [Data_Width-1:0] RAM [0:Memory_Depth-1];
integer i;


always@(*)
begin
    Read_Data=RAM[Address];
    test_value=RAM[{ (Data_Width) {1'b0} }];
end


always@(posedge clk or negedge reset)
begin
    if (!reset)
        begin
            for (i=0;i<Memory_Depth;i=i+1)
                RAM[i]<={ (Data_Width) {1'b0} } ;
        end
    else if (Write_Enable)
            RAM[Address]<=Write_Data;

end
endmodule