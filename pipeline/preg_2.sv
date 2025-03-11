module preg_2(
    input logic clk,reset,stall,rd_en,wr_en,reg_wr,
    input logic [1:0] sel_dm,
    input logic [31:0] alu_out,rdata2,preg_1_pc,preg_1_inst,
    output logic preg_2_rd_en,preg_2_wr_en,preg_2_reg_wr,
    output logic [1:0] preg_2_sel_dm,
    output logic [31:0] preg_2_alu_out,preg_2_rdata2,preg_2_pc,preg_2_inst
    
    
);

always_ff @( posedge clk ) begin 
    
    if (reset | stall ) begin
        preg_2_rd_en<=1'b0;
        preg_2_wr_en<=1'b0;
        preg_2_reg_wr<=1'b0;
        preg_2_sel_dm<=2'b00;
        preg_2_alu_out<=32'b0;
        preg_2_rdata2<=32'b0;
        preg_2_pc<=32'b0;
        preg_2_inst<=32'b0;
        
        
    end
    else begin
        preg_2_rd_en<=rd_en;
        preg_2_wr_en<=wr_en;
        preg_2_reg_wr<=reg_wr;
        preg_2_sel_dm<=sel_dm;
        preg_2_alu_out<=alu_out;
        preg_2_rdata2<=rdata2;
        preg_2_pc<=preg_1_pc;
        preg_2_inst<=preg_1_inst;
    end
end
endmodule