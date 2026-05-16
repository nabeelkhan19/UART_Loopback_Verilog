`timescale 1ns / 1ps

module uart_top_tb;

reg clk;
reg rst;
reg wr_en;
reg rdy_clr;
reg [7:0] data_in;

wire rdy;
wire busy;
wire [7:0] data_out;

uart_top uut (
    .rst(rst),
    .data_in(data_in),
    .wr_en(wr_en),
    .clk(clk),
    .rdy_clr(rdy_clr),
    .rdy(rdy),
    .busy(busy),
    .data_out(data_out)
);

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial
begin

    rst = 1;
    wr_en = 0;
    rdy_clr = 0;
    data_in = 0;

    #100;
    rst = 0;

    #1000;

    // SEND 41
    data_in = 8'h41;
    wr_en = 1;

    #10;
    wr_en = 0;

    wait(rdy);

    $display("Received = %h", data_out);

    #100;

    rdy_clr = 1;
    #10;
    rdy_clr = 0;

    #2000000;

    $finish;

end

endmodule