`timescale 1ns/1ps

module Top_module_test;

    // Inputs
    logic clk;
    logic reset;

    // Instantiate the Unit Under Test (UUT)
    Top_module uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        $display("Initializing inputs...");
        reset = 1;
        #10;
        reset = 0;

        // Add stimulus here
        $display("Starting test sequence...");
        // ...

        // Finish simulation after some time
        #1000;
        $display("Finishing simulation...");
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t, clk=%b, reset=%b", $time, clk, reset);
    end

    // Additional test logic
    initial begin
        // Initialize signals
        init_signals;

        // Reset the device
        reset_seq;

        // Send test data
        fork
            send_data(10000);
            monitor();
        join_any

        $display("************************ Test Summary ************************");
        $display(" \t Tests Passed: %0d/%0d\n \t Tests Failed: %0d/%0d", npassed, ntests, nfailed, ntests);
        $display("************************ Test Summary ************************");
        $stop;
    end

    // Task to monitor outputs
    task automatic monitor;
        // ...existing code...
    endtask

    // Task to send data
    task automatic send_data(int ntest);
        // ...existing code...
    endtask

    // Task to initialize signals
    task automatic init_signals;
        // ...existing code...
    endtask

    // Task to reset the device
    task automatic reset_seq;
        // ...existing code...
    endtask

    // Variables for test results
    int npassed = 0;
    int nfailed = 0;
    int ntests = 10000;

endmodule
