module codificador7seg(
	input S0,S1,S2,S3,
	output HEX00, HEX01, HEX02, HEX03, HEX04, HEX05, HEX06);
	
	wire nS0, nS1, nS2, nS3;
	
	// --- Fios HEX00 ---
	wire andhex00_0, andhex00_1;
	
	// --- Fios HEX01 ---
	wire andhex01_0, andhex01_1;

	// --- Fios HEX02 ---
	wire andhex02_0, andhex02_1, andhex02_2, andhex02_3;
	
	// --- Fios HEX03 ---
	wire andhex03_0, andhex03_1, andhex03_2, andhex03_3;
	
	// --- Lógica para HEX04 ---
	wire andhex04_0, andhex04_1;
	
	// --- Lógica para HEX06 ---
	wire andhex06_0, andhex06_1;
	
	// inversores
	not (nS3, S3);
	not (nS2, S2);
	not (nS1, S1);
	not (nS0, S0);
	

	// --- Lógica para HEX00 ---
	and ah00_1(andhex00_0, nS3, nS2, nS1, S0); // ah0 = andHEX00
	and ah00_2(andhex00_1, nS3, S2, nS1, nS0);
	or orhex00(HEX00, andhex00_0, andhex00_1);
	
	// --- Lógica para HEX01 ---
	and ah01_1(andhex01_0, nS3, nS1, S0);
	and ah01_2(andhex01_1, S3, S2, nS1, nS0);
	or orhex01(HEX01, andhex01_0, andhex01_1);
	
	// --- Lógica para HEX02 ---
	and ah02_1(andhex02_0, nS3, nS2, nS1, S0);
	and ah02_2(andhex02_1, nS3, nS2, S1, nS0);
	and ah02_3(andhex02_2, S3, S2, nS1, nS0);
	and ah02_4(andhex02_3, S3, S2, S1, S0);
	or orhex02(HEX02, andhex02_0, andhex02_1, andhex02_2, andhex02_3);
	
	// --- Lógica para HEX03 ---
	and ah03_1(andhex03_0, nS3, nS2, nS1, S0);
	and ah03_2(andhex03_1, nS3, S2, nS1, nS0);
	and ah03_3(andhex03_2, S3, nS2, S1, nS0);
	and ah03_4(andhex03_3, S3, S2, S1, S0);
	or orhex03(HEX03, andhex03_0, andhex03_1, andhex03_2, andhex03_3);
	
	// --- Lógica para HEX04 ---
	and ah04_1(andhex04_0, nS3, nS2, S1, S0);
	and ah04_2(andhex04_1, nS3, S2, nS1);
	or orhex04(HEX04, andhex04_0, andhex04_1);
	
	// --- Lógica para HEX05 ---
	and andhex05(HEX05, nS3, nS2, S1);
	
	// --- Lógica para HEX06 ---
	and ah06_1(andhex06_0, nS3, nS2, nS1);
	and ah06_2(andhex06_1, S3, S2, nS1, nS0);
	or orhex06(HEX06, andhex06_0, andhex06_1);
	
endmodule
