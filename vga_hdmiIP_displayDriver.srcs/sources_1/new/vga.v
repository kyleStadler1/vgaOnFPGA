`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2024 09:28:54 PM
// Design Name: 
// Module Name: vga
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga(
    input pix_clk, //1080 60!!!
    input lock,
    output reg h_sync,
    output reg v_sync,
    output vde,
    output [11:0] x_pos, 
    output [11:0] y_pos
    );
    reg [11:0] h_ctr = 12'd0;
    reg [11:0] v_ctr = 12'd0;
    reg v_clk = 1'd0; //inverts itself for every new horizontal line
// 640 480 60hz:    
//    parameter H_VIS = 639;
//    parameter H_FP = H_VIS + 16; 
//    parameter H_RT = H_FP + 96;
//    parameter H_BP = 799;
    
//    parameter V_VIS = 479;
//    parameter V_FP = V_VIS + 10 - 1;
//    parameter V_RT = V_FP + 2;
//    parameter V_BP = 524;

    //1920 1080 60hz:
    parameter H_VIS = 1919;
    parameter H_FP = 2007; 
    parameter H_RT = 2051;
    parameter H_BP = 2199;
    
    parameter V_VIS = 1079;
    parameter V_FP = 1083;
    parameter V_RT = 1088;
    parameter V_BP = 1124;
    
    always @ (posedge pix_clk) begin
        if (lock) begin
            if (h_ctr == H_BP) begin 
                h_ctr <= 12'd0;
                v_clk <= 1;
            end
            else begin
                h_ctr <= h_ctr + 1; 
                v_clk <= 0;
            end
            
            case (h_ctr)
                 0 : h_sync <= ~1;
                 H_FP : h_sync <= ~0;
                 H_RT : h_sync <= ~1;
                 default : h_sync <= h_sync;
            endcase         
        end
    end
    
    always @ (posedge v_clk) begin
        if (lock) begin
            if (v_ctr == V_BP) begin 
                v_ctr <= 12'd0;
            end
            else begin
                v_ctr <= v_ctr + 1; 
            end
            case (v_ctr)
                0 : v_sync <= ~1;
                V_FP : v_sync <= ~0;
                V_RT : v_sync <= ~1;
                default : v_sync <= v_sync;
            endcase
        end
    end
    assign vde = (h_ctr < H_VIS && v_ctr < V_VIS);
    assign x_pos = h_ctr;
    assign y_pos = v_ctr;
endmodule