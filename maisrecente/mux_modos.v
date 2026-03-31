module mux_modos (
    input  wire       M1, M0,      
    input  wire       F, T, P, L,   

    output wire [3:0] saida,       
    output wire [6:0] hex,          
    output wire       alerta, invasao, perigo
);

    // Fios internos para receber as saídas de cada bloco
    wire [3:0] sm0, sm1, sm2, sm3;
    wire [6:0] hm0, hm1, hm2, hm3;
    wire am0, im0, pm0, am1, im1, pm1, am2, im2, pm2, am3, im3, pm3;

    // 1. Instanciando os quatro modos (os blocos que acabamos de criar)
    modo_normal      u0 (.F(F), .T(T), .P(P), .L(L), .saida(sm0), .hex(hm0), .alerta(am0), .invasao(im0), .perigo(pm0));
    modo_diagnostico u1 (.F(F), .T(T), .P(P), .L(L), .saida(sm1), .hex(hm1), .alerta(am1), .invasao(im1), .perigo(pm1));
    modo_manutencao  u2 (.F(F), .T(T), .P(P), .L(L), .saida(sm2), .hex(hm2), .alerta(am2), .invasao(im2), .perigo(pm2));
    modo_emergencia  u3 (.F(F), .T(T), .P(P), .L(L), .saida(sm3), .hex(hm3), .alerta(am3), .invasao(im3), .perigo(pm3));

    // 2. Instanciando os MUX 4x1 para rotear o sinal da 'saida' (4 bits)
    mux4x1 m_saida0 (.d0(sm0[0]), .d1(sm1[0]), .d2(sm2[0]), .d3(sm3[0]), .s1(M1), .s0(M0), .out(saida[0]));
    mux4x1 m_saida1 (.d0(sm0[1]), .d1(sm1[1]), .d2(sm2[1]), .d3(sm3[1]), .s1(M1), .s0(M0), .out(saida[1]));
    mux4x1 m_saida2 (.d0(sm0[2]), .d1(sm1[2]), .d2(sm2[2]), .d3(sm3[2]), .s1(M1), .s0(M0), .out(saida[2]));
    mux4x1 m_saida3 (.d0(sm0[3]), .d1(sm1[3]), .d2(sm2[3]), .d3(sm3[3]), .s1(M1), .s0(M0), .out(saida[3]));

    // 3. Instanciando os MUX 4x1 para rotear o sinal do Display 'hex' (7 bits)
    mux4x1 m_hex0 (.d0(hm0[0]), .d1(hm1[0]), .d2(hm2[0]), .d3(hm3[0]), .s1(M1), .s0(M0), .out(hex[0]));
    mux4x1 m_hex1 (.d0(hm0[1]), .d1(hm1[1]), .d2(hm2[1]), .d3(hm3[1]), .s1(M1), .s0(M0), .out(hex[1]));
    mux4x1 m_hex2 (.d0(hm0[2]), .d1(hm1[2]), .d2(hm2[2]), .d3(hm3[2]), .s1(M1), .s0(M0), .out(hex[2]));
    mux4x1 m_hex3 (.d0(hm0[3]), .d1(hm1[3]), .d2(hm2[3]), .d3(hm3[3]), .s1(M1), .s0(M0), .out(hex[3]));
    mux4x1 m_hex4 (.d0(hm0[4]), .d1(hm1[4]), .d2(hm2[4]), .d3(hm3[4]), .s1(M1), .s0(M0), .out(hex[4]));
    mux4x1 m_hex5 (.d0(hm0[5]), .d1(hm1[5]), .d2(hm2[5]), .d3(hm3[5]), .s1(M1), .s0(M0), .out(hex[5]));
    mux4x1 m_hex6 (.d0(hm0[6]), .d1(hm1[6]), .d2(hm2[6]), .d3(hm3[6]), .s1(M1), .s0(M0), .out(hex[6]));

    // 4. Instanciando os MUX 4x1 para rotear os LEDs
    mux4x1 m_alerta  (.d0(am0), .d1(am1), .d2(am2), .d3(am3), .s1(M1), .s0(M0), .out(alerta));
    mux4x1 m_invasao (.d0(im0), .d1(im1), .d2(im2), .d3(im3), .s1(M1), .s0(M0), .out(invasao));
    mux4x1 m_perigo  (.d0(pm0), .d1(pm1), .d2(pm2), .d3(pm3), .s1(M1), .s0(M0), .out(perigo));

endmodule