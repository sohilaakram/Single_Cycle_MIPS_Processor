 module adder

#(parameter Data_Width =32)
    (
    output  wire    [Data_Width-1:0]    Result,
    input   wire    [Data_Width-1:0]   A,B
);
assign Result=A+B;
endmodule