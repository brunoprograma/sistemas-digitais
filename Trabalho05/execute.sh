python gerador_entradas_saidas.py &&
iverilog Trabalho05.v Teste_Sign.v -o sign &&
./sign > files/saida_sign_verilog.txt &&
iverilog Trabalho05.v Teste_Triang.v -o triang &&
./triang > files/saida_triang_verilog.txt &&
diff files/saida_sign_verilog.txt files/saidas_sign.txt || echo &&
diff files/saida_triang_verilog.txt files/saidas_triangulos.txt || echo
