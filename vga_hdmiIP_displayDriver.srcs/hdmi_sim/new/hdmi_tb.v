`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2024 12:39:36 AM
// Design Name: 
// Module Name: hdmi_tb
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


module hdmi_tb;
    wire _clk;
    
    wire hdmi_clk_n;
    wire hdmi_clk_p;
    wire [2:0] hdmi_tx_n;
    wire [2:0] hdmi_tx_p;
    
    wire clk_25_175;
    wire clk_25_175_x5;
    wire clk_25;
    wire clk_125;
    wire reset = 0;
    wire locked;
    clk_wiz_0 myClks(clk_25_175, clk_25, clk_125, clk_25_175_x5, reset, locked, _clk);
    
    wire h_sync;
    wire v_sync;
    wire [9:0] x_pos;
    wire [9:0] y_pos;
    wire vde; 
    vga myVga (clk_25, locked, h_sync, v_sync, vde, x_pos, y_pos);
    
    wire [7:0] red = 8'd128;
    wire [7:0] green = 8'd128;
    wire [7:0] blue = 8'd128;
    
    
//    wire _hdmi_clk_n;
//    wire _hdmi_clk_p;
//    wire [2:0] _hdmi_d_n;
//    wire [2:0] _hdmi_d_p;
    
    hdmi_tx_0 vga_to_hdmi (
        //clocking and reset
        .pix_clk(clk_25),
        .pix_clkx5(clk_125),
        .pix_clk_locked(locked),
        .rst(reset), //active high
        
        //color and sync
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(h_sync),
        .vsync(v_sync),
        .vde(vde),
        
        //audio
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //HDMI Diff outputs
		.TMDS_CLK_P(hdmi_clk_n),          
		.TMDS_CLK_N(hdmi_clk_p),          
		.TMDS_DATA_P(hdmi_tx_n),         
		.TMDS_DATA_N(hdmi_tx_p)  
    );
    
//    assign hdmi_clk_n = _hdmi_clk_n;
//    assign hdmi_clk_p = _hdmi_clk_p;
//    assign hdmi_tx_n = _hdmi_d_n;
//    assign hdmi_tx_p = _hdmi_d_p;
    
    
    initial begin
    #100;
    end
endmodule
