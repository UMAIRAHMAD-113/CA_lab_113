`timescale 1ns/1ps
module reg_file(
    input logic clk,reset,reg_wr,
    input logic [4:0] raddr1,raddr2,waddr, 
    input logic [31:0] wdata,
    
    output logic [31:0] rdata1,rdata2
);
logic [31:0] Registers[31:0] ;

always_comb begin 
    rdata1 = Registers[raddr1];
    rdata2 = Registers[raddr2];
end
always_ff @ (negedge clk) begin

    if (reset) begin
        for (int i =0; i<32 ; i++)begin
            Registers[i] <= 32'h 10;
        end
    end
    else if (reg_wr ) begin
        Registers[waddr] <= wdata ;
    end
end
/* initial begin
Registers[1] <= 32'd1;
Registers[2] <= 32'd2;
Registers[3] <= 32'd3;
Registers[4] <= 32'd4;
Registers[5] <= 32'd5;
Registers[6] <= 32'd6;
Registers[7] <= 32'd7;
Registers[8] <= 32'd7;
Registers[9] <= 32'd8;
Registers[10] <= 32'h8;
Registers[11] <= 32'h9;
Registers[12] <= 32'h34;
Registers[13] <= 32'h34;

end */
endmodule