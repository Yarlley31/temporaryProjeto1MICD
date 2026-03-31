module mux2x1 (
    input d0, d1, sel, 
    output out
);
    wire not_sel, a, b;

    not (not_sel, sel);
    and (a, d0, not_sel);
    and (b, d1, sel);
    or  (out, a, b);
endmodule