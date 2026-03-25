module moduloDiagnostico(
	input F,T,P,L,
	output S3, S2, S1, S0, HEX00, HEX01, HEX02, HEX03, HEX04, HEX05, HEX06	
);
	
	
	// fios S3
	wire w3_1;
	
	// fios S2
	wire andFT, w2_2, w2_3, w2_4;
	
	// fios S1
	wire w1_1, w1_2, w1_3;
	
	// fios S0
	wire w0_1, w0_2, w0_3;
	
	
	// inversores
	not (nF, F);
	not (nT, T);
	not (nP, P);
	not (nL, L);
	

	// --- Lógica para S3 = F * (~P + T) ---
	or oS3_1(w3_1, nP, T);
	and aS3_1(S3, F, w3_1);
	
	// --- Lógica para S2 = (P * (~L + FT)) + (F * ~T * ~L)
	and aFT(andFT, F, T);
	or oS2_1(w2_2, nL, andFT);
	and aS2_1(w2_3, P, w2_2); // ´rimeira parte
	and aS2_2(w2_4, F, nT, nL);  // segunda parte
	or oS2_2(S2, w2_3, w2_4);
	
	
	// --- Lógica para S1 = (T * ~P) + (L * (T + F)) ---
	and aS1_1(w1_1, T, nP); // primeira parte
	or oS1_1(w1_2, T, F);
	and aS1_2(w1_3, L, w1_2); // segunda parte
	or oS1_2(S1, w1_1, w1_3);

	// --- Lógica para S0 = (T * (~F + P)) + (~F * ~P * ~L) ---
	or oS0_1(w0_1, nF, P);
	and aS0_1(w0_2, T, w0_1); // primeira parte
	and aS0_2(w0_3, nF, nP, nL); // segunda parte
	or oS0_2(S0, w0_2, w0_3);	
	
endmodule