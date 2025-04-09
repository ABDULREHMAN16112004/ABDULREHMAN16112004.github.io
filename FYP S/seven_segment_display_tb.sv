module seven_segment_display_tb;
    // Testbench signals
    logic clk;
    logic [3:0] item_price;
    logic [6:0] seven_seg;

    // Instantiate the DUT (Design Under Test)
    seven_segment_display dut (
        .item_price(item_price),
        .seven_seg(seven_seg)
    );

    // Clock generation
    always #5 clk = ~clk; // 100 MHz clock

    // Initial block to apply stimulus
    initial begin
        // Initialize signals
        clk = 0;
        item_price = 4'b0000; // No item selected initially

        // Apply stimulus
        #10 item_price = 4'b0001; // Select item 1
        #10 item_price = 4'b0010; // Select item 2
        #10 item_price = 4'b0011; // Select item 3
        // Add more cases as needed

        // Wait and finish simulation
        #100 $finish;
    end

    // Monitor outputs for debugging
    initial begin
        $monitor("Time: %0t | Item Price: %b | Seven Segment: %b", $time, item_price, seven_seg);
    end
endmodule
