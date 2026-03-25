module moduloManutencao(
	input F, T, P, L,
	output S3, S2, S1, S0
);

	/* Para exibir '' no display, precisamos enviar o valor binário 0110:
       S3 = 0 (GND)
       S2 = 1 (VCC)
       S1 = 1 (VCC)
       S0 = 0 (GND)
   */

	buf b3 (S3, 1'b0); // Força S3 para nível BAIXO (0)
   buf b2 (S2, 1'b1); // Força S2 para nível ALTO (1)
   buf b1 (S1, 1'b1); // Força S1 para nível ALTO (1)
   buf b0 (S0, 1'b0); // Força S0 para nível BAIXO (0)
	
endmodule