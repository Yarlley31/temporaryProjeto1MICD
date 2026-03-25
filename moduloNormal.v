module moduloNormal (
    input F, T, P, L,
    output S3, S2, S1, S0
);

    // --- FIOS PARA INVERSORES ---
    wire nF, nT, nP, nL;
    
    not (nF, F);
    not (nT, T);
    not (nP, P);
    not (nL, L);

    // --- Lógica para S3 ---
    // S3 = F * (~P + T)
    wire w3_1;
    or  oS3_1(w3_1, nP, T);
    and aS3_1(S3, F, w3_1);
    
    // --- Lógica para S2 ---
    // S2 = (P * (~L + (F * T))) + (F * ~T * ~L)
    wire andFT, w2_2, w2_3, w2_4;
    and aFT(andFT, F, T);
    or  oS2_1(w2_2, nL, andFT);
    and aS2_1(w2_3, P, w2_2);
    and aS2_2(w2_4, F, nT, nL);
    or  oS2_2(S2, w2_3, w2_4);
    
    // --- Lógica para S1 ---
    // S1 = (T * ~P) + (L * (T + F))
    wire w1_1, w1_2, w1_3;
    and aS1_1(w1_1, T, nP);
    or  oS1_1(w1_2, T, F);
    and aS1_2(w1_3, L, w1_2);
    or  oS1_2(S1, w1_1, w1_3);

    // --- Lógica para S0 ---
    // S0 = (T * (~F + P)) + (~F * ~P * ~L)
    wire w0_1, w0_2, w0_3;
    or  oS0_1(w0_1, nF, P);
    and aS0_1(w0_2, T, w0_1);
    and aS0_2(w0_3, nF, nP, nL);
    or  oS0_2(S0, w0_2, w0_3);

endmodule