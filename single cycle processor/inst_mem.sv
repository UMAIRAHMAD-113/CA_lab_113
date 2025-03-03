`timescale 1ns/1ps
module inst_mem(
    input logic reset,
    input logic [31:0] addr,
    output logic [31:0] inst 
    
);
logic [31:0] Memory [31:0]='{default:0}; // mem. of 32 reg with 32 bit each
always_comb begin
    inst = Memory[addr>>2];

end
always_comb begin
Memory[1] <=32'h40000000;
Memory[2] <=32'hfe010113;
Memory[3] <=32'h00812e23;
Memory[4] <=32'h02010413;
Memory[5] <=32'h000017b7;
Memory[6] <=32'h0007a787;
Memory[7] <=32'hfef42627;
Memory[8] <=32'hfec42787;
Memory[9] <=32'hfef42427;
Memory[10] <=32'hfe842787;
Memory[11] <=32'hc00797d3;
Memory[12] <=32'h00078513;
Memory[13] <=32'h01c12403;
Memory[14] <=32'h02010113;
Memory[14] <=32'h00008067;
end
endmodule
