module seven_segment_display(
    input logic [3:0] item_price,
    output logic [6:0] seven_seg
);
    always_comb begin
        case (item_price)
            4'd1: seven_seg = 7'b0000110; // Display '1'
            4'd2: seven_seg = 7'b1011011; // Display '2'
            4'd3: seven_seg = 7'b1001111; // Display '3'
            default: seven_seg = 7'b0000000; // Display nothing
        endcase
    end
endmodule
