`timescale 1ns/1ps
module controller(
    input logic [31:0] inst,
    output logic [3:0] alu_op,
    output logic reg_wr
);

logic [2:0]funct3;
logic [6:0]opcode;
always_comb begin 
opcode = inst[6:0];
funct3=inst[14:12];
    case (opcode)
        7'b0110011:begin //R_Type  0110011
            alu_op={funct3,inst[30]};
            reg_wr=1'b1;

    end 
        // default: begin
        //     alu_op=4'b0;
        //     reg_wr=1'b0;
        // end
    endcase
end



endmodule