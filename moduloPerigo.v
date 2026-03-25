module moduloPerigo(
	input F, T, P, L,
	output S3, S2, S1, S0
);

	/* Para exibir 'F' no display, precisamos enviar o valor binário 1111:
       S3 = 1 (VCC)
       S2 = 1 (VCC)
       S1 = 1 (VCC)
       S0 = 1 (VCC)
   */
	 
	buf b3 (S3, 1'b1); // Força S3 para nível ALTO (1)
   buf b2 (S2, 1'b1); // Força S2 para nível ALTO (1)
   buf b1 (S1, 1'b1); // Força S1 para nível ALTO (1)
   buf b0 (S0, 1'b1); // Força S0 para nível ALTO (1)

endmodule