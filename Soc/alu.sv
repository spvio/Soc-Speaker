//ALU: I and R types

//I-Type(sign_extend)

//1.module to handle intermediates w/sign extension
module s_imm(input logic IR[31:0] output logic[31:0] s_imm)  

always_comb begin 
    case(IR[6:0])
    //I type(ALU)
        7'h13: s_imm = {{20{IR[31]}, IR[31:20]}};
    //S type(ALU)
        7'h23: s_imm = {{20{IR[31]}}, IR[31:25], IR[11:7]};

        //no latches
        default: 0;
    endcase


end

endmodule


module MUX_block(input ALU_I_R,input logic[31:0] rs2_val, input logic[31:0] s_imm ,output logic[31:0] val2);
assign val2 = (ALU_I_R) ? s_imm : rs2_val;
endmodule 


//val 2 is sign_extended
module ALU(input logic[31:0] rs1_val, input logic val_2[31:0], output logic[31:0] alu_out);


//think about how "sighn" works later
always_comb begin 
case(IR[14:12])  
    3'b000: alu_out = $signed(rs1_val) + $signed(val_2); 
    //STLI 2:
    3'b010: alu_out = ($signed(rs1_val) < $signed(val_2)) 1 : 0;
    //usigned 
    3'b011: alu_out = (rs1_val < val_2) ? 1:0;
    3'b100: alu_out = rs1_val ^ val_2;
    3'b110: alu_out = rs1_val | val_2;
    3'b111: alu_out = rs1_val & val_2;
    3'b001:
    3'b101:





endcase
end


endmodule 
