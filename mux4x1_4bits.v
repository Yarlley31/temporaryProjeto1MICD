module mux4x1_4bits(
	input [3:0] in0, in1, in2, in3,
	input [1:0] sel,
	output[3:0] out 
);


	mux4x1_1bit bit0 (in0[0], in1[0], in2[0], in3[0], sel[1], sel[0], out[0]);
	mux4x1_1bit bit1 (in0[1], in1[1], in2[1], in3[1], sel[1], sel[0], out[1]);
	mux4x1_1bit bit2 (in0[2], in1[2], in2[2], in3[2], sel[1], sel[0], out[2]);
	mux4x1_1bit bit3 (in0[3], in1[3], in2[3], in3[3], sel[1], sel[0], out[3]);
	
endmodule