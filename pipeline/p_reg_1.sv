module preg_1(
    input logic clk,reset,stall,br_taken,
    input logic [31:0] pc,inst,
    output logic [31:0] preg_1_pc,preg_1_inst
    );

always_ff @( posedge clk or posedge reset ) begin 
    if (reset | stall | br_taken ) begin
        preg_1_pc<=32'b0;
        preg_1_inst<=32'h00000000;
    end
    else begin
        preg_1_pc<=pc;
        preg_1_inst<=inst;
    end
end 
    
endmodule