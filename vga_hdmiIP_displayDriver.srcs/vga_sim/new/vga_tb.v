`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/02/2024 10:54:46 PM
// Design Name: 
// Module Name: vga_tb
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


module vga_tb;
wire _clk = 1;
wire clk_25_175;
wire clk_25_175_x5;
wire clk_25;
wire clk_125;
wire reset;
wire locked;
wire vde;

clk_wiz_0 myClks(clk_25_175, clk_25, clk_125, clk_25_175_x5, reset, locked, _clk);
wire h_sync;
wire v_sync;
wire [9:0] x_pos;
wire [9:0] y_pos;
vga myVga (clk_25_175, locked, h_sync, v_sync, vde, x_pos, y_pos);
initial begin
    #100;
end
endmodule
