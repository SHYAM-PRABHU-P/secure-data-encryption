`timescale 1ns/1ps
module RTL_engin_golden_model_DV_engin_tb();
    reg clk=1;
    reg rst;
    reg en;
    reg [7:0]data_in;
    reg load_seed;
    reg [7:0]seed_in;
    wire [7:0]data_out;
    wire [7:0] data_out_golden;
    
    integer succ_count=0,err_count=0,totl_count=0;
    
    top_prng uut_1(.clk(clk),.rst(rst),.en(en),.seed_in(seed_in),.load_seed(load_seed),.data_in(data_in),.data_out(data_out));
    prng_golden_module uut_2(.clk(clk),.rst(rst),.en(en),.seed_in(seed_in),.load_seed(load_seed),.data_in(data_in),.data_out(data_out_golden));
    
    always begin
        clk=~clk;#0.5;
    end
    
    task enc;
        input [7:0] data;
        begin
            @(posedge clk);
            en=1'b1;    
            data_in=data;
            @(posedge clk);
            en=1'b0;
        end
    endtask
    
    task validate;
        begin
            @(posedge clk);
            if(data_out===data_out_golden) begin
                $display("SUCCESS---DATA RTL=%c,DATA DV=%c",data_out,data_out_golden);
                succ_count=succ_count+1;
            end
            else begin
                $display("ERROR---DATA RTL=%c,DATA DV=%c",data_out,data_out_golden);
                err_count=err_count+1;
            end
            totl_count=totl_count+1;
        end
    endtask
    
    task load;
        input [7:0]l;
        begin
            @(posedge clk);
            load_seed=1'b1;
            seed_in=l;
            @(posedge clk);
            load_seed=1'b0;
        end
    endtask
    
    initial begin
        rst=0;
        en=0;
        data_in=0;
        load_seed=0;
        seed_in=0;
        @(posedge clk);
        rst=1;
        $display("-------------ENCODE of \"verilog\"-------------"); 
        @(posedge clk);
        enc("v");validate();
        enc("e");validate();
        enc("r");validate();
        enc("i");validate();
        enc("l");validate();
        enc("o");validate();
        enc("g");validate();
        
        $display("-------------DECODE of \"ìP½Ä>Ä\"-------------"); 
        
        
        @(posedge clk);
        repeat(2)
        load(8'hCD);
        enc(8'd236);validate();
        enc(8'd80);validate();
        enc(8'd24);validate();
        enc(8'd189);validate();
        enc(8'd196);validate();
        enc(8'd62);validate();
        enc(8'd196);validate();
        
        
        
    end
    
    
endmodule
