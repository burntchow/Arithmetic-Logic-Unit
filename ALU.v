`timescale 1ns / 1ps
// Module definition
module alu_32(A_in, B_in, ALU_Sel, ALU_Out, Carry_Out, Zero, Overflow);
// Define I/O ports 
    input [31:0] A_in;
    input [31:0] B_in;
    input [3:0] ALU_Sel;
    output reg [31:0] ALU_Out; // result 
    output reg Carry_Out;
    output reg Zero;
    output reg Overflow; 
    reg signed [32:0] holder = 0; 
// Describe ALU behavior 
    always@(*)
        
        begin 
            case(ALU_Sel)
                // AND 
                4'b0000: 
                    begin 
                        assign ALU_Out = A_in & B_in;  
                        assign Carry_Out = 1'b0;
                        assign Zero = (ALU_Out == 0);
                        assign Overflow = 1'b0;
                    end 
                
                // OR 
                4'b0001:
                    begin 
                        assign ALU_Out = A_in | B_in;
                        assign Carry_Out = 1'b0;
                        assign Zero = (ALU_Out == 0);
                        assign Overflow = 1'b0;
                    end
                
                // Add
                4'b0010: 
                    begin 
                        assign ALU_Out = $signed(A_in) + $signed(B_in); 
                        assign Carry_Out = 1;
                        assign Zero = (ALU_Out == 0);
                        assign holder = $signed(A_in) + $signed(B_in);
                        if(((2**32)-1) > holder && holder > -((2**32)-1))begin
                            assign Overflow = 0;
                        end else begin
                            assign Overflow = 1;
                        end
                    end 
                    
                // Subtract 
                4'b0110: 
                    begin
                        assign ALU_Out = $signed(A_in) - $signed(B_in); // Sign 
                        assign Carry_Out = 1'b0;
                        assign Zero = (ALU_Out == 0); 
                        assign holder = $signed(A_in) - $signed(B_in);
                        if(((2**32)-1) > holder && holder > -((2**32)-1))begin
                            assign Overflow = 0;
                        end else begin
                            assign Overflow = 1;
                        end
                    end
                    
                // Set Less Than 
                4'b0111: 
                    begin
                        if($signed(A_in) < $signed(B_in))begin 
                            assign ALU_Out = 32'h00000001;
                            //  $display("1 reached");
                        end else begin
                            assign ALU_Out = 32'h00000000;
                            // $display("0 reached");
                        end
                        assign Carry_Out = 1'b0;
                        assign Zero = (ALU_Out == 0);
                        assign Overflow = 1'b0; 
                    end 
                    
                // NOR 
                4'b1100: 
                    begin
                        assign ALU_Out = ~(A_in | B_in);
                        assign Carry_Out = 1'b0;
                        assign Zero = (ALU_Out == 0);
                        assign Overflow = 1'b0;
                    end 
                
                // Equal Comparison
                4'b1111: 
                    begin
                        if(A_in === B_in)begin 
                            assign ALU_Out = 32'h00000001;
                        end else begin
                            assign ALU_Out = 32'h00000000;
                        end
                        assign Carry_Out = 1'b0;
                        assign Zero = (ALU_Out == 0);
                        assign Overflow = 1'b0;
                    end 
            endcase 
        end 
endmodule    // 32-bit ALU 
