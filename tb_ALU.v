`timescale 1ns / 1ps
module tb_ALU(  );
    // Define input and output ports 
    reg [31:0] tb_din_a = 0;
    reg [31:0] tb_din_b = 0; 
    reg [3:0] tb_alu_sel = 0;
    wire [31:0] tb_alu_out;
    wire tb_carry_out;
    wire tb_zero;
    wire tb_overflow; 
    // Port Mapping 
    alu_32 instant(.A_in(tb_din_a), 
                .B_in(tb_din_b), 
                .ALU_Sel(tb_alu_sel),
                .ALU_Out(tb_alu_out),
                .Carry_Out(tb_carry_out),
                .Zero(tb_zero),
                .Overflow(tb_overflow));
    initial
        begin
            // Test 1     
            tb_din_a = 32'h086a0c31;
            tb_din_b = 32'hd785f148;
            tb_alu_sel = 4'b0000; 
            #20; // Run for 20ns 
        
            // Test 2     
            tb_din_a = 32'h086a0c31;
            tb_din_b = 32'h10073fd4;
            tb_alu_sel = 4'b0001; 
            #20; // Run for 20ns 
        
            // Test 3   
            tb_din_a = 32'h086a0c31;
            tb_din_b = 32'h90073fd4;
            tb_alu_sel = 4'b0010; 
            #20; // Run for 20ns 
            
            // Test 4     
            tb_din_a = 32'h086a0c31;
            tb_din_b = 32'h90073fd4;
            tb_alu_sel = 4'b0110; 
            #20; // Run for 20ns 
            
            // Test 5
            tb_din_a = 32'h086a0c31;
            tb_din_b = 32'h90073fd4;
            tb_alu_sel = 4'b0111; 
            #20; // Run for 20ns 
            
            // Test 6    
            tb_din_a = 32'h086a0c31;
            tb_din_b = 32'h90073fd4;
            tb_alu_sel = 4'b1100; 
            #20; // Run for 20ns 
            
            // Test 7     
            tb_din_a = 32'h086a0c31;
            tb_din_b = 32'h086a0c31;
            tb_alu_sel = 4'b1111; 
            #20; // Run for 20ns 
            
            // Test 8     
            tb_din_a = 32'h086a0c31;
            tb_din_b = 32'h10073fd4;
            tb_alu_sel = 4'b1111; 
            #20; // Run for 20ns 
    end 
endmodule
