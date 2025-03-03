`timescale 1ns/1ps

module pc_mux(
    input logic [31:0] pc,
    output logic [31:0] pc_out
);
always_comb begin
    pc_out <= pc+4;
end
endmodule