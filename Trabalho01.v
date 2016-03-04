module Pisca(
  input clk, 
  output led);
  
  assign led = clk;

endmodule

module test;

  reg clk;
  always #2 clk <= ~clk;

  wire led;

  Pisca P(clk, led);

  initial begin
    $dumpvars(0, P);
    #1;
    clk <= 0;
    #500;
    $finish;
  end
endmodule

