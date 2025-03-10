`timescale 1ns/1ps
module inst_mem(
    input logic [31:0] addr,
    output logic [31:0] inst 
);
logic [31:0] Memory [31:0] = '{default:0}; // mem. of 32 reg with 32 bit each

always_comb begin
    inst = Memory[addr >> 2];
end

initial begin
    for (int i = 0; i < 32; i = i + 1) begin
        Memory[i] = 32'h00000000;
    end

    // Load immediate values into registers
    Memory[1] = 32'h00a00513; // addi x10, x0, 10
    Memory[2] = 32'h00b00593; // addi x11, x0, 11

    // R-type instructions
    Memory[3] = 32'h00b50533; // add x10, x10, x11 (add)
    Memory[4] = 32'h40b50533; // sub x10, x10, x11 (subtract)

    // I-type instruction
    Memory[5] = 32'h00c00513; // addi x10, x0, 12

    // S-type instruction
    Memory[6] = 32'h00a52023; // sw x10, 0(x0)

    // B-type instruction
    Memory[7] = 32'h00a50663; // beq x10, x10, offset

    // U-type instruction
    Memory[8] = 32'h00000537; // lui x10, 0x0

    // J-type instruction
    Memory[9] = 32'h0000006f; // jal x1, offset
end

endmodule
