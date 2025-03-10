module Top_module(
    input logic clk, reset
);
logic [31:0] pc, pc_out, inst, rdata1, rdata2, A, B, alu_out, data_memory_output,
            write_back_data, immediate_out;
logic reg_wr, rd_en, wr_en, sel_A, sel_B;
logic [1:0] sel_dm;
logic [2:0] br_type;
logic [3:0] alu_op;
logic br_taken;

// pc
pc u_pc(
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out),
    .pc(pc)
);

// pc_mux
pc_mux u_pc_mux(
    .pc(pc),
    .alu_out(alu_out),
    .pc_out(pc_out),
    .br_taken(br_taken)
);

// Instruction memory
inst_mem u_inst_mem(
    .addr(pc),
    .inst(inst)
);

// Register file
reg_file u_reg_file(
    .clk(clk),
    .reset(reset),
    .reg_wr(reg_wr),
    .raddr1(inst[19:15]),
    .raddr2(inst[24:20]),
    .waddr(inst[11:7]),
    .wdata(write_back_data), // Ensure wdata is connected to write_back_data
    .rdata1(rdata1),
    .rdata2(rdata2)
);

// mux_A
mux_A u_mux_A(
    .pc(pc),
    .rdata1(rdata1),
    .sel_A(sel_A),
    .A(A)
);

// mux_B
mux_B u_mux_B(
    .immediate_out(immediate_out),
    .rdata2(rdata2),
    .sel_B(sel_B),
    .B(B)
);

// ALU
alu u_alu(
    .A(A),
    .B(B),
    .alu_op(alu_op),
    .alu_out(alu_out)
);

// Controller
controller u_controller(
    .inst(inst),
    .reg_wr(reg_wr),
    .sel_B(sel_B),
    .alu_op(alu_op),
    .br_type(br_type),
    .rd_en(rd_en),
    .wr_en(wr_en),
    .sel_dm(sel_dm),
    .sel_A(sel_A)
);

// Branch condition
branch_condition u_branch_condition(
    .rdata1(rdata1),
    .rdata2(rdata2),
    .br_type(br_type),
    .br_taken(br_taken)
);

// Immediate generator
immediate_gen u_immediate_gen(
    .inst(inst),
    .immediate_out(immediate_out)
);

// Data memory mux
data_memory_mux u_data_memory_mux(
    .data_memory_output(data_memory_output),
    .sel_dm(sel_dm),
    .alu_out(alu_out),
    .pc(pc),
    .write_back_data(write_back_data)
);

// Data memory
data_memory u_data_memory(
    .data_memory_input(alu_out),
    .write_data(rdata2),
    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_memory_output(data_memory_output)
);

endmodule
