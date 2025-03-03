
module Top_module(
    input logic clk,reset
);
logic reg_wr;
logic [3:0] alu_op;
logic [4:0] raddr1,raddr2,waddr;
logic [31:0] pc,pc_out,inst,wdata,rdata1,rdata2,A,B,alu_out;

// pc
// output declaration of module pc


pc u_pc(
    .clk    	(clk     ),
    .reset  	(reset   ),
    .pc_out 	(pc_out  ),
    .pc     	(pc      )
);

// output declaration of module pc_mux


pc_mux u_pc_mux(
    .pc     	(pc      ),
    .pc_out 	(pc_out  )
);


// Instruction mem
// output declaration of module inst_mem

inst_mem u_inst_mem(
    .reset 	(reset  ),
    .addr  	(pc   ),
    .inst  	(inst   )
);


// output declaration of module reg_file


reg_file u_reg_file(
    .clk    	(clk     ),
    .reset  	(reset   ),
    .reg_wr 	(reg_wr  ),
    .raddr1 	(inst[19:15]  ),
    .raddr2 	(inst[24:20]  ),
    .waddr  	(inst[11:7]  ),
    .wdata  	(alu_out   ),
    .rdata1 	(rdata1  ),
    .rdata2 	(rdata2  )
);

// reg file
//reg_file reg_file(.clk, .reset, .reg_wr, .raddr1(inst[19:15]), 
//.raddr2(inst[24:20]), .waddr(inst[11:7]), .wdata ,.rdata1, .rdata2);

// ALU
// output declaration of module alu


alu u_alu(
    .A       	(rdata1        ),
    .B       	(rdata2        ),
    .alu_op  	(alu_op   ),
    .alu_out 	(alu_out  )
);

//alu ALU(.A(rdata1), .B(rdata2));
// controller 

controller u_controller(
    .inst   	(inst    ),
    .alu_op 	(alu_op  ),
    .reg_wr 	(reg_wr  )
);




endmodule