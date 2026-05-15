//prone to change.. memory is grows backward
'include CPU.sv
module Memory(input clk, input[31:0] bus, input address_load, input data_load, input mem_enable);

//8 bits
logic[7:0] BRAM[127:0];
logic[31:0] address;
logic[31:0] data;

always_comb(posedge clk) begin 

if(address_load) address <= bus;
if(data_load)    address <= data;

if(mem_enable) begin
    if(r_w) 
        data    <= {BRAM[address -3], BRAM[address-2], BRAM[address-1], BRAM[address]};
        
    else begin BRAM[address-3]  <= data[31:24];
               BRAM[address-2]  <= data[23:16];
               BRAM[address-1]  <= data[15:8];
               BRAM[address]    <= data[7:0];

    end
end
end


endmodule