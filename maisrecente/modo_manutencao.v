module modo_manutencao (
    input F, T, P, L,
    output [3:0] saida, 
    output [6:0] hex,
    output alerta, invasao, perigo
);
    supply1 vcc; 
    supply0 gnd; 

    // Saida: 4'b0110
    buf (saida[3], gnd);
    buf (saida[2], vcc);
    buf (saida[1], vcc);
    buf (saida[0], gnd);

    // Hex: 7'b0000010
    buf (hex[6], gnd);
    buf (hex[5], gnd);
    buf (hex[4], gnd);
    buf (hex[3], gnd);
    buf (hex[2], gnd);
    buf (hex[1], vcc);
    buf (hex[0], gnd);

    // Todos LEDs ligados
    buf (alerta, vcc);
    buf (invasao, vcc);
    buf (perigo, vcc);

endmodule