// recebe todos os pontos por 6 entradas e retorna desligado para sign=não e ligado para sign=sim
// segue o mesmo modelo do código python
module sign(
  input [10:0] p1x,
  input [10:0] p1y,
  input [10:0] p2x,
  input [10:0] p2y,
  input [10:0] p3x,
  input [10:0] p3y,
  output s
);

  wire signed [23:0] mult1;
  wire signed [23:0] mult2;

  assign mult1 = (p1x - p3x) * (p2y - p3y);
  assign mult2 = (p2x - p3x) * (p1y - p3y);

  assign s = mult1 < mult2;

endmodule

// Recebe duas entradas ptx e pty para o ponto a ser verificado e mais 6 entradas
// que são os pontos que formam o triângulo em questão
// retorna desligado para dentroTriang=não e ligado para dentroTriang=sim
module dentroTriang(
  input [10:0] ptx,
  input [10:0] pty,
  input [10:0] p1x,
  input [10:0] p1y,
  input [10:0] p2x,
  input [10:0] p2y,
  input [10:0] p3x,
  input [10:0] p3y,
  output s
);

  wire teste1, teste2, teste3;

  sign T1(ptx, pty, p1x, p1y, p2x, p2y, teste1);
  sign T2(ptx, pty, p2x, p2y, p3x, p3y, teste2);
  sign T3(ptx, pty, p3x, p3y, p1x, p1y, teste3);

  assign s = (teste1 == teste2) & (teste2 == teste3);

endmodule


module teste;
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
    $dumpvars(0, T1);
    #1;
    // dados do triangulo
    p1x <= 11'b01100100000; // 800
    p1y <= 11'b01001011000; // 600
    p2x <= 11'b01100100000; // 800
    p2y <= 11'b00100101100; // 300
    p3x <= 11'b00110010000; // 400
    p3y <= 11'b01001011000; // 600
    #20;
    // teste ponto 01
    // saida tem que retornar 0
    ptx <= 11'b00111011011; // 475
    pty <= 11'b00111000010; // 450
    #40;
    // teste ponto 02
    // saida tem que retornar 1
    ptx <= 11'b01001001001; // 585
    pty <= 11'b00111010110; // 470
    #500;
    $finish;
  end

endmodule
