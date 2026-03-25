module mux4x1_1bit(
	input F, T, P, L,
	input M1, M0,
	output out
);

	wire w0, w1, w2, w3;
	
	// inversores
	not n1 (nM1, M1);
	not n0(nM0, M0);
	
	
	// Lógica das portas AND
	and a0(w0, F, nM1, nM0); // Ativo quando 00
	and a1(w1, T, nM1, M0); // Ativo quando 01
	and a2(w2, P, M1, nM0); // Ativo quando 10
	and a3(w3, L, M1, M0); // Ativo quando 11
	
	
	or final_or(out, w0, w1, w2, w3);
	
endmodule