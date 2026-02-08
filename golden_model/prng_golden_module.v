module prng_golden_module(
    input clk,rst,en,load_seed,
    input [7:0]seed_in,
    input [7:0]data_in,
    output reg [7:0]data_out
    );
    localparam [7:0] SEED=8'hCD;
    reg enc_en;
    reg [7:0]enc_data_in;
    reg [7:0]prng;
    
    function [7:0]poly(input [7:0]data);
        reg feedback;
        begin
            feedback=data[7]^data[5]^data[4]^data[3];
            poly={data[6:0],feedback};
        end
    endfunction
    
    always @(posedge clk or negedge rst) begin
        if(!rst)
            prng[7:0]<=SEED[7:0];
        else if(load_seed==1'b1)
            prng[7:0]<=seed_in[7:0];
        else if(en)
            prng<=poly(prng);
            
    end
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            enc_en<=0;
            enc_data_in<=0;
            data_out<=0;
        end
        else begin
            enc_en<=en;
            enc_data_in[7:0]<=data_in[7:0];
            if(enc_en)
                data_out[7:0]<=prng[7:0]^enc_data_in[7:0];
        end
            
    end
endmodule
