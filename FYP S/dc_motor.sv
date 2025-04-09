module dc_motor(
    input logic clk,
    input logic dispense,
    output logic DC_motor
);
    always_ff @(posedge clk) begin
        DC_motor = dispense ? 1 : 0;
    end
endmodule
