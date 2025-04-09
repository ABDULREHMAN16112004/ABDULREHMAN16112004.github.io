module vending_machine_tb;
    // Testbench signals
    logic clk;
    logic reset;
    logic pushbutton;
    logic [3:0] row;
    logic [3:0] col;
    logic IR_Sensor;
    logic [6:0] seven_seg;
    logic red_led;
    logic [2:0] green_leds;
    logic DC_motor;
    logic buzzer;

    // Instantiate the DUT (Design Under Test)
    vending_machine dut (
        .clk(clk),
        .reset(reset),
        .pushbutton(pushbutton),
        .row(row),
        .col(col),
        .IR_Sensor(IR_Sensor),
        .seven_seg(seven_seg),
        .red_led(red_led),
        .green_leds(green_leds),
        .DC_motor(DC_motor),
        .buzzer(buzzer)
    );

    // Clock generation
    always #5 clk = ~clk; // 100 MHz clock

    // Initial block to apply stimulus
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        pushbutton = 0;
        row = 4'b1111; // No key pressed initially
        IR_Sensor = 0;

        // Apply reset
        #10 reset = 0;

        // Simulate the pushbutton press
        #20 pushbutton = 1;
        #10 pushbutton = 0;

        // Simulate keypad input for item selection
        // Scan columns and set rows to simulate key presses for numbers 0 to 3
        #30 col = 4'b1110; row = 4'b1110; // Simulate key press at row 1, column 1 (Key 0)
        #10 row = 4'b1111; // Release key
        //#30 col = 4'b1110; row = 4'b1101; // Simulate key press at row 2, column 1 (Key 1)
        //#10 row = 4'b1111; // Release key
        //#30 col = 4'b1110; row = 4'b1011; // Simulate key press at row 3, column 1 (Key 2)
        //#10 row = 4'b1111; // Release key
        //#30 col = 4'b1110; row = 4'b0111; // Simulate key press at row 4, column 1 (Key 3)
        //#10 row = 4'b1111; // Release key

        // Simulate payment completion
        #40 row = 4'b1101; // Simulate another key press for payment

        // Simulate the IR Sensor detection (item dispensed)
        #60 IR_Sensor = 1;

        // Wait and finish simulation
        #100 $finish;
    end

    // Monitor outputs for debugging
    initial begin
        $monitor("Time: %0t | State: %b | Seven Segment: %b | Red LED: %b | Green LEDs: %b | DC Motor: %b | Buzzer: %b", 
                 $time, dut.current_state, seven_seg, red_led, green_leds, DC_motor, buzzer);
    end
endmodule
