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
	
	// --- LÓGICA DO DISPLAY ---
	
	// fios Hex00
	wire wH0_1;
	
	// fios hex 01
	wire wH1_1, wH1_2, wH1_3, wH1_4;
	
	// fios hex02
	wire wH2_1, wH2_2, wH2_3;
	
	// fios hex03
	wire wH3_0, wH3_1, wH3_2, wH3_3;
	
	// fios hex04
	wire wH4_1, wH4_2, wH4_3;
	
	// fios hex05
	wire wH5_1;
	
	// fios hex06
	wire wH6_1, wH6_2, wH6_3, wH6_4, wH6_5;
	
	
	// inversores saídas
	not (nS3, S3);
	not (nS2, S2);
	not (nS1, S1);
	not (nS0, S0);
	
	// --- Lógica do HEX00 = S2 * ~S1 * xnor(~S3, ~S0))---
	xnor xnH0(wH0_1, nS3, nS0);
	and aH0(HEX00, S2, nS1, wH0_1);
	
	// --- Lógica do HEX01 = S2 * (~S3 * xnor(S1, S0) + (S3 * S1 * S0)) ---
	xnor xnH1(wH1_1, S1, S0);
	and aH1_1(wH1_2, nS3, wH1_1);
	and aH1_2(wH1_3, S3, S1, S0);
	or oH1_1(wH1_4, wH1_2, wH1_3);
	and aH1_3(HEX01, S2, wH1_1);
	
	// --- Lógica do HEX02 = S1 * (~S3 * ~S2 * ~S0 + S3 * S2) ---
	and aH2_1(wH2_1, nS3, nS2, nS0);
	and aH2_2(wH2_2, S3, S2);
	or oH2_1(wH2_3, wH2_1, wH2_2);
	and aH2_3(HEX02, S1, wH2_2);

	// --- Lógica do HEX03 = ~S3 * S2 * xnor(S1, S0) + ~S3 * ~S2 * ~S1 * S0 + S3 * ~S2 * S1 * ~S0 --- (~S1 * ~S0 + S1 * S0)
	xnor xnH3(wH3_0, S1, S0);
	and aH3_1(wH3_1, nS3, S3, wH3_0);
	and aH3_2(wH3_2, nS3, nS2, nS1, S0);
	and aH3_3(wH3_3, S3, nS2, S1, nS0);
	or oH3(HEX03, wH3_1, wH3_2, wH3_3);
	
	// --- Lógica do HEX04 = S3 * (~S2 * S0 + S2 * ~S1)
	and aH4_1(wH4_1, nS2, S0);
	and aH4_2(wH4_2, S2, nS1);
	or oH4(wH4_3, wH4_1, wH4_2);
	and aH4_3(HEX04, S3, wH4_3);
	
	// --- Lógica do HEX05 = S3 * S2 * (S1 + nS0)
	or oH5(wH5_1, S1, nS0);
	and aH5(HEX05, S3, S2, wH5_1);
	
	// --- Lógica do HEX06 = (~S2 * (~S1 + ~S3)) + (S3 * ~S1) + (S2 * ~S0 * (S3 + S1))
	or oH6_1(wH6_1, nS1, nS3);
	and aH6_1(wH6_2, nS2, wH6_1); //1
	and aH6_2(wH6_3, S3, nS1); //2
	or oH6_2(wH6_4, S3, S1);
	and aH6_3(wH6_5, S2, nS0, wH6_4);
	or oH6_3(HEX06, wH6_2, wH6_3, wH6_5);
	
	
endmodule