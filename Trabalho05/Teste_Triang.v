// feito com base em https://github.com/wuerges/aula-sist-digitais-2016-1/blob/master/pli/testbench.v
module teste;

  integer input_data;
  integer get_data;

  reg signed [10:0] ptx;
  reg signed [10:0] pty;
  reg signed [10:0] p1x;
  reg signed [10:0] p1y;
  reg signed [10:0] p2x;
  reg signed [10:0] p2y;
  reg signed [10:0] p3x;
  reg signed [10:0] p3y;
  wire saida;

  dentroTriang T1(ptx, pty, p1x, p1y, p2x, p2y, p3x, p3y, saida);

  initial begin
    input_data = $fopen("files/entradas_triangulos.txt", "r");
    if (input_data == 0) begin
      $display("arquivo de entradas vazio");
      $finish;
    end
  end

  always #2 begin
    if (!$feof(input_data)) begin
      $display("%5d %5d %5d %5d %5d %5d %5d %5d = %d", ptx, pty, p1x, p1y, p2x, p2y, p3x, p3y, saida);
      get_data = $fscanf(input_data, "%d %d %d %d %d %d %d %d\n", ptx, pty, p1x, p1y, p2x, p2y, p3x, p3y);
    end
    else begin
      $finish;
    end
  end

endmodule
