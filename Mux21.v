module Mux21
    #(parameter Data_Width =32)
(
    output  wire    [Data_Width-1:0]   Mux_out,
    input   wire    [Data_Width-1:0]   A,B,
    input   wire                       sel
);
    assign Mux_out=    sel? B :   A;
endmodule