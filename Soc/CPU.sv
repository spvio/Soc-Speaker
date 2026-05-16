//KEY NOTES: using 1 bus for now..
//3'b000: default
//3'b001: PC
//3'b010: MEM
//3'b100: ALU
module Control_Unit(input clk, input logic[31:0] IR, output reg_load, output logic[2:0] bus_select);

always_ff @(posedge i_clk) begin : FSM
    //1.fetch: get value from PC
    case(STATE):
        fetch_1: begin 
            bus_select      <= 3'b001;
            address_load    <= 1'b1;
            data_load       <= 1'b0;
            STATE           <= fetch_2;
        end

        fetch_2: begin 
            mem_enable  <= 1'b1;
            r_w         <= 1'b1;
            bus_select  <=  3'b000;
            address_load<= 1'b0;
            PC_select   <= 3'b001; //(adds -4)
            STATE       <= fetch_3;        
        end

        fetch_3: begin 
            bus_select  <= 3'b010;
            IR_load     <= 1'b1;
            PC_select   <= 3'b000;
            PC_load     <= 1'b1;
            STATE       <= decode;
        end



        //what base type it is: (I-type: x13 &  R-type: x66)
        //(I-type)
        decode: begin 
            case(IR[6:0])
                x13:begin  //(I-type/ALU)
                alu_I_R     <= 1'b1;
                bus_select  <= 3'b100;
                STATE       <= x13;  
                end;

            endcase

        end

        x13: begin 
            dst_load <= 1'b1
            STATE <= fetch; 
        end


    



    endcase

end

endmodule 

module Register_File(input clk, input logic IR[31:0], input logic[31:0] bus, input dst_load, input IR_load, input PC_load, output logic[31:0] r_val);
    logic[31:0] REGISTERS[0:31]; 
    logic[31:0] PC;
    logic[31:0] IR;
    //r0 = 0 (always)
    initial begin 
            REGISTERS[0] = 0;  
            PC = 127; 
    end

    always_comb @(posedge clk) begin 
        if(dst_load) = 1'b1     REGISTERS[IR[11:7]] <= bus;
        if(PC_load)  = 1'b1     PC  <= bus;

    end
    assign   r1_val = REGISTERS[IR[19:15]];  
    assign   r2_val = REGISTERS[IR[24:20]];  


endmodule 




