`timescale 1ns / 1ps

module prng(
    input clk,rst,
    input [7:0]seed_in,
    input load_seed,en,
    output reg [7:0]prng
    );
    localparam [7:0]SEED=8'hCD; 
    wire feedback;
    assign feedback=prng[7]^prng[5]^prng[4]^prng[3];
    
    always @(posedge clk or negedge rst) begin
        if(!rst)
            prng<=SEED;
        else if(load_seed==1'b1)
            prng<=seed_in;
        else if(en==1'b1)
            prng<={prng[6:0],feedback};
    end
endmodule
