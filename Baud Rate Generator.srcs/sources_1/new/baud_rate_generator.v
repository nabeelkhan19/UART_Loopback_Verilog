`timescale 1ns / 1ps

module baud_rate_generator(
    input clk,
    input rst,
    output tx_enb,
    output rx_enb
);

reg [12:0] tx_counter;
reg [9:0]  rx_counter;

always @(posedge clk or posedge rst)
begin
    if(rst)
        tx_counter <= 0;
    else
    begin
        if(tx_counter == 5207)
            tx_counter <= 0;
        else
            tx_counter <= tx_counter + 1'b1;
    end
end

always @(posedge clk or posedge rst)
begin
    if(rst)
        rx_counter <= 0;
    else
    begin
        if(rx_counter == 324)
            rx_counter <= 0;
        else
            rx_counter <= rx_counter + 1'b1;
    end
end

assign tx_enb = (tx_counter == 0);
assign rx_enb = (rx_counter == 0);

endmodule