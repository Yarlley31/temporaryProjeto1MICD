module modo_diagnostico (
    input F, T, P, L,
    output [3:0] saida, 
    output [6:0] hex,
    output alerta, invasao, perigo
);
    // Inversores globais
    wire nF, nT, nP, nL;
    not (nF, F);
    not (nT, T);
    not (nP, P);
    not (nL, L);

    // --- LÓGICA DA SAÍDA (4 bits) ---
    wire w_s0_1, w_s0_2, w_s0_3;
    and (w_s0_1, nF, T);
    and (w_s0_2, F, T, P);
    and (w_s0_3, nF, nT, nP, nL);
    or  (saida[0], w_s0_1, w_s0_2, w_s0_3);

    wire w_s1_1, w_s1_2, w_s1_3, w_s1_4;
    and (w_s1_1, nF, T, nP);
    and (w_s1_2, nF, T, L);
    and (w_s1_3, F, nT, L);
    and (w_s1_4, F, T);
    or  (saida[1], w_s1_1, w_s1_2, w_s1_3, w_s1_4);

    wire w_s2_1, w_s2_2, w_s2_3;
    and (w_s2_1, nF, P, nL);
    and (w_s2_2, F, nT, nL);
    and (w_s2_3, F, T, P);
    or  (saida[2], w_s2_1, w_s2_2, w_s2_3);

    wire w_s3_1, w_s3_2;
    and (w_s3_1, F, nT, nL);
    and (w_s3_2, F, T);
    or  (saida[3], w_s3_1, w_s3_2);

    // --- LÓGICA DO DISPLAY HEX (7 bits) ---
    and (hex[0], nF, nT, nL);

    wire w_h1_1, w_h1_2, w_h1_3;
    and (w_h1_1, nF, T, P, nL);
    and (w_h1_2, F, nT, nL);
    and (w_h1_3, F, T, P);
    or  (hex[1], w_h1_1, w_h1_2, w_h1_3);

    wire w_h2_1, w_h2_2;
    and (w_h2_1, F, nT);
    and (w_h2_2, F, T, P);
    or  (hex[2], w_h2_1, w_h2_2);

    wire w_h3_1, w_h3_2;
    and (w_h3_1, nF, nT, nL);
    and (w_h3_2, F, T);
    or  (hex[3], w_h3_1, w_h3_2);

    wire w_h4_1, w_h4_2;
    and (w_h4_1, nF, nT, nL);
    and (w_h4_2, nF, T);
    or  (hex[4], w_h4_1, w_h4_2);

    wire w_h5_1, w_h5_2, w_h5_3, w_h5_4;
    and (w_h5_1, nF, nT, nP, nL);
    and (w_h5_2, nF, T, nP);
    and (w_h5_3, nF, T, P, L);
    and (w_h5_4, F, nT, L);
    or  (hex[5], w_h5_1, w_h5_2, w_h5_3, w_h5_4);

    wire w_h6_1, w_h6_2, w_h6_3;
    and (w_h6_1, nF, nT, nP);
    and (w_h6_2, nF, nT, P, L);
    and (w_h6_3, F, nT, nL);
    or  (hex[6], w_h6_1, w_h6_2, w_h6_3);

    // --- LÓGICA DOS LEDs (DESLIGADOS NO DIAGNÓSTICO) ---
    supply0 gnd;
    buf (alerta, gnd);
    buf (invasao, gnd);
    buf (perigo, gnd);

endmodule