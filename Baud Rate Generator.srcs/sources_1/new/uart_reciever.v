`timescale 1ns / 1ps

module uart_receiver(
    input clk,
    input rst,
    input rx,
    input rdy_clr,
    input clk_en,

    output reg rdy,
    output reg [7:0] data_out
);

parameter idle_state  = 2'b00;
parameter data_state  = 2'b01;
parameter stop_state  = 2'b10;

reg [1:0] state;

reg [2:0] index;
reg [7:0] temp;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= idle_state;
        index <= 0;
        temp <= 0;
        data_out <= 0;
        rdy <= 0;
    end

    else
    begin

        if(rdy_clr)
            rdy <= 0;

        if(clk_en)
        begin

            case(state)

            // WAIT FOR START BIT
            idle_state:
            begin
                if(rx == 0)
                begin
                    index <= 0;
                    state <= data_state;
                end
            end

            // RECEIVE DATA
            data_state:
            begin
                temp[index] <= rx;

                if(index == 3'd7)
                begin
                    state <= stop_state;
                end
                else
                begin
                    index <= index + 1'b1;
                end
            end

            // STOP BIT
            stop_state:
            begin
                data_out <= temp;
                rdy <= 1'b1;
                state <= idle_state;
            end

            default:
                state <= idle_state;

            endcase
        end
    end
end

endmodule