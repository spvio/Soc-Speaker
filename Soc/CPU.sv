//KEY NOTES: using 1 bus for now..
module Control_Unit(input clk, output reg_load, output logic[2:0] bus_select);

always_ff @(posedge i_clk) begin : FSM
    //1.fetch: get value from PC
    case(STATE):
        fetch_1: begin 
            bus_select      <= 3'b001;
            address_load    <= 1'b1;
            data_load       <= 1'b0;
        end

        fetch_2: begin 
            mem_enable  <= 1'b1;
            r_w         <= 1'b1;
            bus_select  <=  3'b000;
            address_load<= 1'b0;
            PC_select   <= 3'b001; //(adds -4)        
        end

        fetch_3: begin 
            bus_select  <= 3'b010;
            IR_load     <= 1'b1;
            PC_select   <= 3'b000;
            PC_load     <= 1'b1;
        end



        //what base type it is: (I-type: x13)
        decode: begin 


        end

    



    endcase

end

endmodule 

module Register_File(input clk, input[15:0] bus, input dst_load, input IR_load, input PC_load, input[4:0] dst);
    logic[31:0] REGISTERS[0:31]; 
    logic[31:0] PC;
    logic[31:0] IR;
    //r0 = 0 (always)
    initial begin 
            REGISTERS[0] = 0;  
            PC = 127; 
    end

    always_comb @(posedge clk) begin 
        if(dst_load) = 1'b1  REGISTERS[dst] <= bus;
        if(PC_load)  = 1'b1     PC  <= bus;
    end


endmodule 




