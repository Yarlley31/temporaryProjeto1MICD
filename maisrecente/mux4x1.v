module mux4x1 (
    input d0, d1, d2, d3, 
    input s1, s0, 
    output out
);
    wire m0, m1;

    mux2x1 low  (.d0(d0), .d1(d1), .sel(s0), .out(m0));
    mux2x1 high (.d0(d2), .d1(d3), .sel(s0), .out(m1));
    mux2x1 final(.d0(m0), .d1(m1), .sel(s1), .out(out));
endmodule