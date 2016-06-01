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

	assign s = teste1 == teste2 & teste2 == teste3;

endmodule


module romTriang(
	input [3:0] endereco,
	output [65:0] triangulo,
	output [3:0] qtde
);

reg [65:0] info;
assign triangulo = info;

assign qtde = 4'd2;

always @(endereco) begin
	case (endereco)
		4'd0: info <= {11'd10, 11'd10, 11'd200, 11'd100, 11'd300, 11'd300};
		4'd1: info <= {11'd800, 11'd600, 11'd800, 11'd300, 11'd400, 11'd600};
		default: info <= 65'bZ;
	endcase
end

endmodule


module verPonto(
	input clk,
	input [10:0] x,
	input [10:0] y,
	output pronto,
//	output valido,
	output cor
);

reg p;
// reg v;
reg c;

wire [10:0] p1x;
wire [10:0] p1y;
wire [10:0] p2x;
wire [10:0] p2y;
wire [10:0] p3x;
wire [10:0] p3y;
wire s;

wire [3:0] qtde;
wire [65:0] triangulo;
reg [3:0] endereco;

assign pronto = p;
// assign valido = v;
assign cor = c;

assign p1x = triangulo[10:0];
assign p1y = triangulo[21:11];
assign p2x = triangulo[32:22];
assign p2y = triangulo[43:33];
assign p3x = triangulo[54:44];
assign p3y = triangulo[65:55];

initial begin
	p <= 1'b0; // pronto
	// v <= 1'b0; // valido
	c <= 1'b0; // cor
	endereco <= 4'd0;
end

romTriang MEM0(endereco, triangulo, qtde);
dentroTriang DT0(x, y, p1x, p1y, p2x, p2y, p3x, p3y, s);

always @(x or y) begin
	p <= 1'b0; // pronto
	// v <= 1'b0; // valido
	c <= 1'b0; // cor
	endereco <= 4'd0;
end

always @(posedge clk) begin
	if (endereco < qtde && c == 1'b0) begin
		if (s) begin
			c <= 1'b1;
		end
		endereco <= endereco + 4'd1;
	end else begin
		p <= 1'b1;
	end
end

endmodule

module teste;
	reg signed [10:0] ponto_x;
	reg signed [10:0] ponto_y;
	reg clock;
	wire ok;
	wire P_B;

	always #2 clock <= ~clock;

	verPonto VP1(clock, ponto_x, ponto_y, ok, P_B);

	initial begin
		$dumpvars(0, VP1);
		#1;
		clock = 1'b0;
		// teste ponto 01
		// saida tem que retornar 0
		#20;
		ponto_x <= 11'd475; // 475
		ponto_y <= 11'd450; // 450
		#40;
		// teste ponto 02
		// saida tem que retornar 1
		ponto_x <= 11'd585; // 585
		ponto_y <= 11'd470; // 470
		#100;
		$finish;
	end

endmodule