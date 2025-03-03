`timescale 1ns/1ps
module test_bench;

    // Signals
    logic clock;
    logic reset;

    // Instantiate the processor
    Top_module uut (
        .clk(clock),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clock = 1;
        forever #5 clock = ~clock; // Toggle clock every 5ns
    end

    initial begin
        reset = 1;
        #10 reset = 0;  // De-assert reset after 10ns
        #200;
        
        $finish; // End simulation
    end


endmodule
