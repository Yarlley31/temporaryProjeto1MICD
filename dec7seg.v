module dec7seg (
    input S3, S2, S1, S0,
    output HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6
);

    // Inversores para ter as entradas negadas disponíveis
    wire n3, n2, n1, n0;
    not (n3, S3);
    not (n2, S2);
    not (n1, S1);
    not (n0, S0);

    // --- Lógica para HEX0 (Segmento a) ---
    wire w0_1, w0_2;
    and (w0_1, n3, S2, n1, n0);
    and (w0_2, S3, S2, n1, S0);
    or  (HEX0, w0_1, w0_2);

    // --- Lógica para HEX1 (Segmento b) ---
    wire w1_1, w1_2;
    and (w1_1, S2, S1, n0);
    and (w1_2, S3, S1, S0);
    or  (HEX1, w1_1, w1_2);

    // --- Lógica para HEX2 (Segmento c) ---
    wire w2_1;
    and (w2_1, n3, n2, S1, n0);
    buf (HEX2, w2_1); // O buffer apenas passa o sinal

    // --- Lógica para HEX3 (Segmento d) ---
    wire w3_1, w3_2, w3_3;
    and (w3_1, n3, S2, n1, n0);
    and (w3_2, n3, n2, n1, S0);
    and (w3_3, S2, S1, S0);
    or  (HEX3, w3_1, w3_2, w3_3);

    // --- Lógica para HEX4 (Segmento e) ---
    wire w4_1, w4_2, w4_3;
    and (w4_1, n0, S2, n1);     // Simplificação para economizar portas
    and (w4_2, n3, S0);
    and (w4_3, n3, S2);
    or  (HEX4, n0, w4_2, w4_3); // Exemplo de lógica simplificada

    // --- Lógica para HEX5 (Segmento f) ---
    wire w5_1, w5_2, w5_3;
    and (w5_1, n3, n2, S0);
    and (w5_2, n3, n2, S1);
    and (w5_3, n3, S1, S0);
    or  (HEX5, w5_1, w5_2, w5_3);

    // --- Lógica para HEX6 (Segmento g) ---
    wire w6_1, w6_2;
    and (w6_1, n3, n2, n1);
    and (w6_2, n3, S2, S1, S0);
    or  (HEX6, w6_1, w6_2);

endmodule