`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2024 02:54:40 PM
// Design Name: 
// Module Name: top_pmodVGA
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


module top_pmodVGA(
    input clk,
    output JB1_P, //R0
    output JB1_N, //R1
    output JB2_P, //R2
    output JB2_N, //R3
    output JB3_P, //B0
    output JB3_N, //B1
    output JB4_P, //B2
    output JB4_N, //B3
    
    output JA1_P, //G0
    output JA1_N, //G1
    output JA2_P, //G2
    output JA2_N, //G3
    output JA3_P, //HS
    output JA3_N, //VS
    output JA4_P, //NC
    output JA4_N //NC
    );
    
    wire clk_148_5;
    wire reset = 0;
    wire locked;
    clk_wiz_0 myClks(clk_148_5, reset, locked, clk);
    
    wire h_sync;
    wire v_sync;
    wire [11:0] x_pos;
    wire [11:0] y_pos;
    wire vde; 
    vga myVga (clk_148_5, locked, h_sync, v_sync, vde, x_pos, y_pos);
    
    wire [3:0] red = x_pos[10:7];
    wire [3:0] green = y_pos[10:7];
    wire [3:0] blue = {x_pos[10]&y_pos[10], x_pos[9]&y_pos[9], x_pos[8]&y_pos[8], x_pos[7]&y_pos[7]};
    
//    reg [3:0] red;
//    reg [3:0] green;
//    reg [3:0] blue;
//    wire [23:0] concat = {x_pos, y_pos};
    
//    always @(posedge clk_148_5) begin
//        red <= concat[3:0];
//        green <= concat[7:4];
//        blue <= concat[11:8];
//    end
    
    
    
    assign JB1_P = red[0] & vde;
    assign JB1_N = red[1] & vde;
    assign JB2_P = red[2] & vde;
    assign JB2_N = red[3] & vde;
    
    assign JB3_P = blue[0] & vde;
    assign JB3_N = blue[1] & vde;
    assign JB4_P = blue[2] & vde;
    assign JB4_N = blue[3] & vde;
   
    assign JA1_P = green[0] & vde;
    assign JA1_N = green[1] & vde;
    assign JA2_P = green[2] & vde;
    assign JA2_N = green[3] & vde;

//    assign JB1_P = x_pos[8] & vde;
//    assign JB1_N = x_pos[9] & vde;
//    assign JB2_P = x_pos[10] & vde;
//    assign JB2_N = x_pos[11] & vde & y_pos[3];
    
//    assign JB3_P = x_pos[8] & vde;
//    assign JB3_N = x_pos[9] & vde;
//    assign JB4_P = x_pos[10] & vde;
//    assign JB4_N = x_pos[11] & vde & y_pos[3];
   
//    assign JA1_P = x_pos[8] & vde;
//    assign JA1_N = x_pos[9] & vde;
//    assign JA2_P = x_pos[10] & vde;
//    assign JA2_N = x_pos[11] & vde;
    
    assign JA3_P = h_sync;
    assign JA3_N = v_sync;
    
endmodule
