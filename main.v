module main(
	input F, T, P, L,
	input M1, M0,
	output HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6
);
	
	// BARRAMENTOS INTERNOS
	// Cada modo gera um código hexadecimal de 4 bits
	wire [3:0] w_normal;
	wire [3:0] w_diagnostico;
	wire [3:0] w_manutencao;
	wire [3:0] w_perigo;
	
	// Fio que transporta o código ESCOLHIDO pelo MUX
	wire [3:0] w_hex_selecionado;
	
	
	// ---------------------------------------------------------
   // 1. INSTANCIAÇÃO DOS MODOS (Geradores de Código)
   // ---------------------------------------------------------
	
	
	// M00: Modo Normal
	moduloNormal modo00 (
		.F(F), .T(T), .P(P), .L(L),
		.S3(w_normal[3]), .S2(w_normal[2]), .S1(w_normal[1]), .S0(w_normal[0])
	);
	
	// M01: Modo Diagnóstico
	moduloDiagnostico modo01 (
		.F(F), .T(T), .P(P), .L(L), 
		.S3(w_diagnostico[3]), .S2(w_diagnostico[2]), .S1(w_diagnostico[1]), .S0(w_diagnostico[0])
	);
	
	// M10: Modo Manutenção
	moduloManutencao modo10 (
		.S3(w_manutencao[3]), .S2(w_manutencao[2]), .S1(w_manutencao[1]), .S0(w_manutencao[0])
    );
	 
	// M11: Modo Perigo
	moduloPerigo modo11 (
        .S3(w_perigo[3]), .S2(w_perigo[2]), .S1(w_perigo[1]), .S0(w_perigo[0])
    );
	 
	 
	 // ---------------------------------------------------------
    // 2. O SELETOR (Multiplexador 4x1 de 4 bits)
    // ---------------------------------------------------------
    // Ele olha para M1 e M0 e escolhe qual dos 4 fios acima passa adiante
	 
	 
	 mux4x1_4bits seletor (
        .in0(w_normal),
        .in1(w_diagnostico),
        .in2(w_manutencao),
        .in3(w_perigo),
        .sel({M1, M0}),
        .out(w_hex_selecionado)
    );
	 
	 
	 // ---------------------------------------------------------
    // 3. DECODIFICADOR ÚNICO (7 Segmentos)
    // ---------------------------------------------------------
    // Agora o display recebe apenas o que o MUX deixou passar
	 
	 dec7seg display_final (
        .S3(w_hex_selecionado[3]), 
        .S2(w_hex_selecionado[2]), 
        .S1(w_hex_selecionado[1]), 
        .S0(w_hex_selecionado[0]),
        .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), 
        .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .HEX6(HEX6)
    );
	
endmodule
