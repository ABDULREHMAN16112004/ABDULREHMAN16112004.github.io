module fsm_tb;
    // Testbench signals
    logic clk;
    logic reset;
    logic pushbutton;
    logic [3:0] keypad;
    logic IR_Sensor;
    logic [2:0] current_state;
    logic red_led;
    logic [2:0] green_leds;
    logic DC_motor;
    logic buzzer;

    // Instantiate the DUT (Design Under Test)
    fsm dut (
        .clk(clk),
        .reset(reset),
        .pushbutton(pushbutton),
        .keypad(keypad),
        .IR_Sensor(IR_Sensor),
        .current_state(current_state),
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
        keypad = 4'b0000;
        IR_Sensor = 0;

        // Apply reset
        #10 reset = 0;

        // Simulate the pushbutton press
        #20 pushbutton = 1;
        #10 pushbutton = 0;

        // Simulate keypad input for item selection
        #30 keypad = 4'b0001; // Select item 1
        #20 keypad = 4'b0000; // Release keypad

        // Simulate payment completion
        #40 keypad = 4'b0010; // Simulate correct payment input

        // Simulate the IR Sensor detection (item dispensed)
        #60 IR_Sensor = 1;

        // Wait and finish simulation
        #100 $finish;
    end

    // Monitor outputs for debugging
    initial begin
        $monitor("Time: %0t | State: %b | Red LED: %b | Green LEDs: %b | DC Motor: %b | Buzzer: %b", 
                 $time, current_state, red_led, green_leds, DC_motor, buzzer);
    end
endmodule
