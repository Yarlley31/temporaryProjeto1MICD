// ============================================================
// COMPONENTES BÁSICOS (ESTRUTURAIS)
// ============================================================

// Multiplexador 2x1 gate-level
module mux2x1 (input d0, d1, sel, output out);
    wire not_sel, a, b;
    not (not_sel, sel);
    and (a, d0, not_sel);
    and (b, d1, sel);
    or  (out, a, b);
endmodule

// Multiplexador 4x1 usando mux2x1
module mux4x1 (input d0, d1, d2, d3, input s1, s0, output out);
    wire m0, m1;
    mux2x1 low  (.d0(d0), .d1(d1), .sel(s0), .out(m0));
    mux2x1 high (.d0(d2), .d1(d3), .sel(s0), .out(m1));
    mux2x1 final(.d0(m0), .d1(m1), .sel(s1), .out(out));
endmodule

// Multiplexador 16x1 usando mux4x1 (para as tabelas de verdade de 4 entradas)
module mux16x1 (input [15:0] d, input [3:0] s, output out);
    wire [3:0] m;
    mux4x1 mux0 (.d0(d[0]),  .d1(d[1]),  .d2(d[2]),  .d3(d[3]),  .s1(s[1]), .s0(s[0]), .out(m[0]));
    mux4x1 mux1 (.d0(d[4]),  .d1(d[5]),  .d2(d[6]),  .d3(d[7]),  .s1(s[1]), .s0(s[0]), .out(m[1]));
    mux4x1 mux2 (.d0(d[8]),  .d1(d[9]),  .d2(d[10]), .d3(d[11]), .s1(s[1]), .s0(s[0]), .out(m[2]));
    mux4x1 mux3 (.d0(d[12]), .d1(d[13]), .d2(d[14]), .d3(d[15]), .s1(s[1]), .s0(s[0]), .out(m[3]));
    mux4x1 final(.d0(m[0]),  .d1(m[1]),  .d2(m[2]),  .d3(m[3]),  .s1(s[3]), .s0(s[2]), .out(out));
endmodule

// ============================================================
// MUX 4x1 — TOP LEVEL (ESTRUTURAL)
// ============================================================
module mux_modos (
    input  wire       M1, M0,      
    input  wire       F, T, P, L,   

    output wire [3:0] saida,       
    output wire [6:0] hex,          
    output wire       alerta, invasao, perigo
);

    wire [3:0] sm0, sm1, sm2, sm3;
    wire [6:0] hm0, hm1, hm2, hm3;
    wire am0, im0, pm0, am1, im1, pm1, am2, im2, pm2, am3, im3, pm3;

    // Instâncias dos modos
    modo_normal      u0 (F, T, P, L, sm0, hm0, am0, im0, pm0);
    modo_diagnostico u1 (F, T, P, L, sm1, hm1, am1, im1, pm1);
    modo_manutencao  u2 (F, T, P, L, sm2, hm2, am2, im2, pm2);
    modo_emergencia  u3 (F, T, P, L, sm3, hm3, am3, im3, pm3);

    // MUX final para selecionar qual modo vai para a saída
    // Para 'saida' (4 bits)
    genvar i;
    generate
        for (i=0; i<4; i=i+1) begin : gen_saida
            mux4x1 m_saida (.d0(sm0[i]), .d1(sm1[i]), .d2(sm2[i]), .d3(sm3[i]), .s1(M1), .s0(M0), .out(saida[i]));
        end
        for (i=0; i<7; i=i+1) begin : gen_hex
            mux4x1 m_hex (.d0(hm0[i]), .d1(hm1[i]), .d2(hm2[i]), .d3(hm3[i]), .s1(M1), .s0(M0), .out(hex[i]));
        end
    endgenerate

    mux4x1 m_alerta  (.d0(am0), .d1(am1), .d2(am2), .d3(am3), .s1(M1), .s0(M0), .out(alerta));
    mux4x1 m_invasao (.d0(im0), .d1(im1), .d2(im2), .d3(im3), .s1(M1), .s0(M0), .out(invasao));
    mux4x1 m_perigo  (.d0(pm0), .d1(pm1), .d2(pm2), .d3(pm3), .s1(M1), .s0(M0), .out(perigo));

endmodule

// ============================================================
// MODO NORMAL (ESTRUTURAL VIA MUX 16x1)
// ============================================================
module modo_normal (
    input F, T, P, L,
    output [3:0] saida, output [6:0] hex,
    output alerta, invasao, perigo
);
    wire [3:0] s_in = {F, T, P, L};

    // Exemplo de mapeamento: Saida[0] para cada combinação de FTPL
    // 0000->1, 0001->0, 0010->0, 0011->0, 0100->1, 0101->1, 0110->1, 0111->1, 1000->0, etc...
    mux16x1 m_s0 (.d(16'b1100000011110001), .s(s_in), .out(saida[0]));
    mux16x1 m_s1 (.d(16'b1111101010110000), .s(s_in), .out(saida[1]));
    mux16x1 m_s2 (.d(16'b1100010101000100), .s(s_in), .out(saida[2]));
    mux16x1 m_s3 (.d(16'b1111010100000000), .s(s_in), .out(saida[3]));

    // Mapeamento HEX (baseado nos valores do case original)
    mux16x1 m_h0 (.d(16'b0000000000000101), .s(s_in), .out(hex[0]));
    mux16x1 m_h1 (.d(16'b1100010101000000), .s(s_in), .out(hex[1]));
    mux16x1 m_h2 (.d(16'b1100111100000000), .s(s_in), .out(hex[2]));
    mux16x1 m_h3 (.d(16'b1111000000000101), .s(s_in), .out(hex[3]));
    mux16x1 m_h4 (.d(16'b0000000011110101), .s(s_in), .out(hex[4]));
    mux16x1 m_h5 (.d(16'b0000101010110001), .s(s_in), .out(hex[5]));
    mux16x1 m_h6 (.d(16'b0000010100001011), .s(s_in), .out(hex[6]));

    // Mapeamento LEDs
    mux16x1 m_al (.d(16'b1011101000001001), .s(s_in), .out(alerta));
    mux16x1 m_in (.d(16'b0000100000000010), .s(s_in), .out(invasao));
    mux16x1 m_pe (.d(16'b1111111100110100), .s(s_in), .out(perigo));
endmodule

// ============================================================
// MODO DIAGNÓSTICO (ESTRUTURAL VIA MUX 16x1)
// ============================================================
module modo_diagnostico (
    input F, T, P, L,
    output [3:0] saida, output [6:0] hex,
    output alerta, invasao, perigo
);
    wire [3:0] s_in = {F, T, P, L};
    // Mesmas lógicas de saída do Normal, mas LEDs são 0 fixo
    mux16x1 m_s0 (.d(16'b1100000011110001), .s(s_in), .out(saida[0]));
    mux16x1 m_s1 (.d(16'b1111101010110000), .s(s_in), .out(saida[1]));
    mux16x1 m_s2 (.d(16'b1100010101000100), .s(s_in), .out(saida[2]));
    mux16x1 m_s3 (.d(16'b1111010100000000), .s(s_in), .out(saida[3]));
    
    mux16x1 m_h0 (.d(16'b0000000000000101), .s(s_in), .out(hex[0]));
    mux16x1 m_h1 (.d(16'b1100010101000000), .s(s_in), .out(hex[1]));
    mux16x1 m_h2 (.d(16'b1100111100000000), .s(s_in), .out(hex[2]));
    mux16x1 m_h3 (.d(16'b1111000000000101), .s(s_in), .out(hex[3]));
    mux16x1 m_h4 (.d(16'b0000000011110101), .s(s_in), .out(hex[4]));
    mux16x1 m_h5 (.d(16'b0000101010110001), .s(s_in), .out(hex[5]));
    mux16x1 m_h6 (.d(16'b0000010100001011), .s(s_in), .out(hex[6]));

    assign alerta = 1'b0;
    assign invasao = 1'b0;
    assign perigo = 1'b0;
endmodule

// ============================================================
// MODO MANUTENÇÃO E EMERGÊNCIA (ESTRUTURAL - CONSTANTES)
// ============================================================
module modo_manutencao (
    input F, T, P, L,
    output [3:0] saida, output [6:0] hex,
    output alerta, invasao, perigo
);
    // Saida 4'b0110, Hex 7'b0100000, LEDs 1
    assign saida   = 4'b0110;
    assign hex     = 7'b0000010;
    assign alerta  = 1'b1;
    assign invasao = 1'b1;
    assign perigo  = 1'b1;
endmodule

module modo_emergencia (
    input F, T, P, L,
    output [3:0] saida, output [6:0] hex,
    output alerta, invasao, perigo
);
    // Saida 4'b1111, Hex 7'b0001110, Perigo 1
    assign saida   = 4'b1111;
    assign hex     = 7'b0001110;
    assign alerta  = 1'b0;
    assign invasao = 1'b0;
    assign perigo  = 1'b1;
endmodule
