 module modo_emergencia (
    input F, T, P, L,
    output [3:0] saida, 
    output [6:0] hex,
    output alerta, invasao, perigo
);
    supply1 vcc; 
    supply0 gnd; 

    // Saida: 4'b1111
    buf (saida[3], vcc);
    buf (saida[2], vcc);
    buf (saida[1], vcc);
    buf (saida[0], vcc);

    // Hex: 7'b0001110
    buf (hex[6], gnd);
    buf (hex[5], gnd);
    buf (hex[4], gnd);
    buf (hex[3], vcc);
    buf (hex[2], vcc);
    buf (hex[1], vcc);
    buf (hex[0], gnd);

    // Apenas perigo ligado
    buf (alerta, gnd);
    buf (invasao, gnd);
    buf (perigo, vcc);

endmodule