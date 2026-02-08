module top_prng(
    input clk,rst,en,load_seed,
    input [7:0]seed_in,
    input [7:0]data_in,
    output reg [7:0]data_out
    );
    
    reg [7:0]enc_data_in;
    reg enc_en;
    wire [7:0]prng;
    prng uut(.clk(clk),.rst(rst),.seed_in(seed_in),.load_seed(load_seed),.en(en),.prng(prng));
    
    always @(posedge clk or negedge rst) begin
        if(!rst) begin
            enc_en<=0;
            enc_data_in<=0;
        end
        else begin
            enc_en<=en;
            enc_data_in[7:0]<=data_in[7:0];
        end
    end
    
    always @(posedge clk or negedge rst) begin
        if(!rst)
            data_out<=0;
        else if(enc_en)
            data_out[7:0]<=prng[7:0]^enc_data_in[7:0];
    end
endmodule
