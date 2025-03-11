`timescale 1ns/1ps
module pc(
    input logic clk,reset,
    input logic [31:0] pc_out,
    output logic [31:0] pc
);


always_ff @(posedge clk ) begin
    if (reset) begin
        pc <= 32'h00000000;
    end
    else begin 
        pc <= pc_out ;
    end
    
end
endmodule
