module buzzer(
    input logic clk,
    input logic activate,
    output logic buzzer
);
    always_ff @(posedge clk) begin
        buzzer = activate ? 1 : 0;
    end
endmodule
