module Top_module(
    input logic clk, reset
);
logic [31:0] pc, pc_out, inst, rdata1, rdata2, A, B, alu_out, data_memory_output,
            write_back_data, immediate_out,
            preg_1_pc,preg_1_inst,
            preg_2_pc,preg_2_inst,preg_2_alu_out,preg_2_rdata2, data2;
            
logic reg_wr, rd_en, wr_en, sel_A, sel_B, stall, f_sel_A, f_sel_B, preg_2_rd_en,preg_2_wr_en,preg_2_reg_wr;
logic [1:0] sel_dm, preg_2_sel_dm;
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

// output declaration of module preg_1


preg_1 u_preg_1(
    .clk         	(clk          ),
    .reset       	(reset        ),
    .stall       	(stall        ),
    .br_taken    	(br_taken     ),
    .pc          	(pc           ),
    .inst        	(inst         ),
    .preg_1_pc   	(preg_1_pc    ),
    .preg_1_inst 	(preg_1_inst  )
);


// Register file
reg_file u_reg_file(
    .clk(clk),
    .reset(reset),
    .reg_wr(reg_wr),
    .raddr1(preg_1_inst[19:15]),
    .raddr2(preg_1_inst[24:20]),
    .waddr(preg_2_inst[11:7]),
    .wdata(write_back_data), // Ensure wdata is connected to write_back_data
    .rdata1(rdata1),
    .rdata2(rdata2)
);

// output declaration of module bmux_A
wire [31:0] data1;

bmux_A u_bmux_A(
    .write_back_data 	(write_back_data  ),
    .rdata1          	(rdata1           ),
    .f_sel_A         	(f_sel_A          ),
    .data1           	(data1            )
);

// mux_A
mux_A u_mux_A(
    .pc(preg_1_pc),
    .data1(data1),
    .sel_A(sel_A),
    .A(A)
);

// output declaration of module bmux_B


bmux_B u_bmux_B(
    .rdata2          	(rdata2           ),
    .write_back_data 	(write_back_data  ),
    .f_sel_B         	(f_sel_B          ),
    .data2           	(data2            )
);

// mux_B
mux_B u_mux_B(
    .immediate_out(immediate_out),
    .rdata2(data2),
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
    .inst(preg_1_inst),
    .reg_wr(reg_wr),
    .sel_B(sel_B),
    .alu_op(alu_op),
    .br_type(br_type),
    .rd_en(rd_en),
    .wr_en(wr_en),
    .sel_dm(sel_dm),
    .sel_A(sel_A),
    .stall(stall),
    .f_sel_A(f_sel_A),
    .f_sel_B(f_sel_B),
    .reg_2_inst(preg_2_inst)
);

// Branch condition
branch_condition u_branch_condition(
    .rdata1(data1),
    .rdata2(data2),
    .br_type(br_type),
    .br_taken(br_taken)
);

// Immediate generator
immediate_gen u_immediate_gen(
    .inst(preg_1_inst),
    .immediate_out(immediate_out)
);

// output declaration of module preg_2


preg_2 u_preg_2(
    .clk            	(clk             ),
    .reset          	(reset           ),
    .stall          	(stall           ),
    .rd_en          	(rd_en           ),
    .wr_en          	(wr_en           ),
    .reg_wr         	(reg_wr          ),
    .sel_dm         	(sel_dm          ),
    .alu_out        	(alu_out         ),
    .rdata2         	(rdata2          ),
    .preg_1_pc      	(preg_1_pc       ),
    .preg_1_inst    	(preg_1_inst     ),
    .preg_2_rd_en   	(preg_2_rd_en    ),
    .preg_2_wr_en   	(preg_2_wr_en    ),
    .preg_2_reg_wr  	(preg_2_reg_wr   ),
    .preg_2_sel_dm  	(preg_2_sel_dm   ),
    .preg_2_alu_out 	(preg_2_alu_out  ),
    .preg_2_rdata2  	(preg_2_rdata2   ),
    .preg_2_pc      	(preg_2_pc       ),
    .preg_2_inst    	(preg_2_inst     )
);

// Data memory mux
data_memory_mux u_data_memory_mux(
    .data_memory_output(data_memory_output),
    .sel_dm(preg_2_sel_dm),
    .alu_out(preg_2_alu_out),
    .pc(preg_2_pc),
    .write_back_data(write_back_data)
);

// Data memory
data_memory u_data_memory(
    .data_memory_input(preg_2_alu_out),
    .write_data(preg_2_rdata2),
    .clk(clk),
    .reset(reset),
    .wr_en(preg_2_wr_en),
    .rd_en(preg_2_rd_en),
    .data_memory_output(data_memory_output)
);

endmodule
