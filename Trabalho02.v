module Led (input CLOCK_50, input [0:0]KEY, output [0:0]LEDG);

    reg [25:0] counter;
    reg state;
    
    assign LEDG[0] = state;
    
    always @(posedge CLOCK_50) begin
        if (KEY[0] == 1) begin
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
