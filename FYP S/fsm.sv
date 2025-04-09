module fsm(
    input logic clk,
    input logic reset,
    input logic pushbutton,
    input logic [3:0] keypad,
    input logic IR_Sensor,
    output logic [2:0] current_state,
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

    state_t state, next_state;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: if (pushbutton) next_state = SELECT;
            SELECT: if (keypad != 4'b0000) next_state = PAYMENT;
            PAYMENT: next_state = DISPENSE; // Logic to handle payment
            DISPENSE: if (IR_Sensor) next_state = COMPLETE;
            COMPLETE: next_state = IDLE;
        endcase
    end

    // Output logic
    always_ff @(posedge clk) begin
        red_led = 0;
        green_leds = 3'b000;
        DC_motor = 0;
        buzzer = 0;
        case (state)
            IDLE: red_led = 1;
            SELECT: green_leds = 3'b111;
            DISPENSE: DC_motor = 1;
            COMPLETE: buzzer = 1;
        endcase
    end

    // Output the current state
    assign current_state = state;

endmodule
