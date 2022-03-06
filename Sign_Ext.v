module Sign_Ext 
#(parameter Output_Width=32,
            Input_Width=16)
(
    output  wire [Output_Width-1:0] Ext_out,
    input   wire   [Input_Width-1:0]   Ext_in
);

localparam Sign_bit=Output_Width-Input_Width-1;
localparam Rep=Output_Width-Input_Width;

assign Ext_out={{Rep{Ext_in[Sign_bit]}},Ext_in};

endmodule