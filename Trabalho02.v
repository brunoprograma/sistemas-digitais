module Led (input clk, input rst, output led);

    reg [25:0] counter;
    reg state;
    
    assign led = state;
    
    always @ (posedge clk, rst) begin
        if (rst == 1) begin
            counter <= 0;
            state <= 0;
        end else begin
	    if (counter == 50000000) begin
	        counter <= 0;
	        state <= ~state;
	    end else begin
	        counter <= counter + 1;
	    end
        end
    end

endmodule
