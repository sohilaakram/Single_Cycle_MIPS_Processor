module Shift_Left_Twice 
#(parameter Data_Width=32)
(
    output  wire    [Data_Width-1:0]    shift_out,
    input   wire    [Data_Width-1:0]    shift_in
);

assign shift_out={{shift_in[Data_Width-2:0]},{2{1'b0}}};
endmodule