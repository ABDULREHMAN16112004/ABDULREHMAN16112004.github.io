module vending_machine(
    input logic clk,
    input logic reset,
    input logic pushbutton,
    input logic [3:0] row,   // 4 row wires
    output logic [3:0] col,  // 4 column wires
    input logic IR_Sensor,
    output logic [6:0] seven_seg,
    output logic red_led,
    output logic [2:0] green_leds,
    output logic DC_motor,
    output logic buzzer
);
    // Define state encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        SELECT = 3'b001,
        PAYMENT = 3'b010,
        DISPENSE = 3'b011,
        COMPLETE = 3'b100
    } state_t;

    state_t current_state, next_state;
    logic [1:0] selected_item; // Adjusted to match the simplified keypad output
    logic [3:0] price;
    logic item_detected;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: if (pushbutton) next_state = SELECT;
            SELECT: if (selected_item != 2'b00) next_state = PAYMENT;
            PAYMENT: next_state = DISPENSE; // Logic to handle payment
            DISPENSE: if (item_detected) next_state = COMPLETE;
            COMPLETE: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        red_led = 0;
        green_leds = 3'b000;
        case (current_state)
            IDLE: red_led = 1;
            SELECT: green_leds = 3'b111;
        endcase
    end

    // Instantiate component modules
    keypad u_keypad(
        .clk(clk), 
        .row(row), 
        .col(col), 
        .item_selected(selected_item)
    );
    seven_segment_display u_seven_segment_display(
        .item_price(price), 
        .seven_seg(seven_seg)
    );
    ir_sensor u_ir_sensor(
        .clk(clk), 
        .IR_Sensor(IR_Sensor), 
        .item_detected(item_detected)
    );
    dc_motor u_dc_motor(
        .clk(clk), 
        .dispense(current_state == DISPENSE), 
        .DC_motor(DC_motor)
    );
    buzzer u_buzzer(
        .clk(clk), 
        .activate(current_state == COMPLETE), 
        .buzzer(buzzer)
    );
endmodule
