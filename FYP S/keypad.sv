module keypad(
    input logic clk,
    input logic [3:0] row,   // 4 row inputs
    output logic [3:0] col,  // 4 column outputs
    output logic [1:0] item_selected // Scanning only numbers 0-3
);
    logic [3:0] col_scan;
    logic [3:0] row_value;

    // Keypad scanning logic for numbers 0 to 3
    always_ff @(posedge clk) begin
        col_scan = 4'b1110;  // Start with the first column
        row_value = row;

        if (row_value != 4'b1111) begin
            case (col_scan)
                4'b1110: begin
                    if (row_value == 4'b1110) item_selected = 2'b00; // Key 0
                    if (row_value == 4'b1101) item_selected = 2'b01; // Key 1
                    if (row_value == 4'b1011) item_selected = 2'b10; // Key 2
                    if (row_value == 4'b0111) item_selected = 2'b11; // Key 3
                end
                default: item_selected = 2'b00;
            endcase
        end else begin
            item_selected = 2'b00; // Default to 0 when no key is pressed
        end
    end

    assign col = col_scan;
endmodule
