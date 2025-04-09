module ir_sensor(
    input logic clk,
    input logic IR_Sensor,
    output logic item_detected
);
    always_ff @(posedge clk) begin
        item_detected = IR_Sensor;
    end
endmodule
