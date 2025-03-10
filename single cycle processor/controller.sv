module controller (
    input logic [31:0] inst,
    output logic reg_wr,
    output logic sel_B, 
    output logic [3:0] alu_op,
    output logic [2:0] br_type,
    output logic rd_en,
    output logic wr_en,
    output logic [1:0] sel_dm,
    output logic sel_A
);

    logic [6:0] opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;

    always_comb begin
        opcode = inst[6:0];
        funct3 = inst[14:12];
        funct7 = inst[31:25];
        alu_op = 4'h0;
        reg_wr = 1'b0;
        sel_B = 1'b0; 
        rd_en = 1'b0; 
        wr_en = 1'b0; 
        sel_dm = 2'b00; 
        sel_A = 1'b1;        
        br_type = 3'd2;

        case (opcode)
            // R-type instructions
            7'b0110011: begin
                reg_wr = 1'b1;
                sel_B = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_dm = 2'b00;
                sel_A = 1'b1; 
                br_type = 3'd2;
                alu_op = {inst[14:12], inst[30]}; 
            end

            // I-type instructions
            7'b0010011: begin
                reg_wr = 1'b1;
                sel_B = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_dm = 2'b00;
                sel_A = 1'b1;
                br_type = 3'd2;
                alu_op = {inst[14:12], inst[30]}; 
            end

            // Load type instructions
            7'b0000011: begin
                reg_wr = 1'b1;
                sel_B = 1'b1;
                rd_en = 1'b1;
                wr_en = 1'b0;
                alu_op = 4'h0; // ADD for address calculation
                sel_dm = 2'b01;
                sel_A = 1'b1; 
                br_type = 3'd2;
            end

            // Store type instructions
            7'b0100011: begin
                reg_wr = 1'b0;
                sel_B = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b1;
                sel_A = 1'b1; 
                sel_dm = 2'b01;
                br_type = 3'd2;
                alu_op = 4'h0;
            end

            // Branch type instructions
            7'b1100011: begin
                reg_wr = 1'b0;
                sel_B = 1'b1;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_dm = 2'b01;
                sel_A = 1'b0;    
                br_type = funct3;
                alu_op = 4'h0;
            end
            
            // U-type instructions (LUI)
            7'b0110111: begin
                reg_wr = 1'b1;
                alu_op = 4'd12;
                sel_B = 1;
                sel_A = 1'b0;
                sel_dm = 2'b00;
                rd_en = 1'b0;
                wr_en = 1'b0;
                br_type = 3'd2;
            end 

            // U-type instructions (AUIPC)
            7'b0010111: begin
                reg_wr = 1'b1;
                alu_op = 4'd0;
                sel_B = 1;
                sel_A = 0;
                sel_dm = 2'b00;
                rd_en = 1'b0;
                wr_en = 1'b0;
                br_type = 3'd2;
            end 

            // Jump type instructions (JAL)
            7'b1101111: begin
                sel_A = 1'b0;
                sel_B = 1'b1;
                br_type = 3'd3;
                rd_en = 1'b0;
                wr_en = 1'b0;
                alu_op = 4'd0;
                reg_wr = 1'b1;
                sel_dm = 2'b10;
            end

            // JALR type instructions
            7'b1100111: begin
                sel_A = 1'b1;
                sel_B = 1'b1;
                br_type = 3'd3;
                rd_en = 1'b0;
                wr_en = 1'b0;
                alu_op = 4'd0;
                reg_wr = 1'b1;               
                sel_dm = 2'b10;
            end

            default: begin
                reg_wr = 1'b0;
                sel_B = 1'b0;
                rd_en = 1'b0;
                wr_en = 1'b0;
                sel_A = 1'b1;
                sel_dm = 2'b00;
                alu_op = 4'h0; // Default to ADD
                br_type = 3'd2;
            end
        endcase
    end

endmodule
