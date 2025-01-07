module fulladder( a,b,cin, sum, carry );
    input a;
    input b;
    input cin;
    output sum;
    output carry;
    
    wire t1,t2,t3;
   xor (sum, a, b, cin);
   and  (t1, a, b);
   and  (t2, b, cin);
   and (t3, a, cin);
   or (carry, t1, t2, t3);
    
endmodule

module halfadder(a,b,sum, carry);
    input a;
    input b;
    output carry;
    output sum;
    
    wire t2,t3,t4,t5;
    and g1(carry,a,b);
    not g3(t2,a);
    not g4(t3,b);
    and g5(t4,t2,b);
    and g6(t5,t3,a);
    or g7(sum,t4,t5);
    
endmodule


module wallace(input [7:0] a1, b1, output [15:0] result
    );
	 
	 wire [7:0] p0,p1,p2,p3,p4,p5,p6,p7;
	 wire [7:0] r1, r2, r3, r4, r5, r6, r7, r8;
	 wire [64:0] cr;
	 wire [53:0] s;
	 
	 

	 assign r1[7:0] =  {8{b1[0]}};
	 assign r2[7:0] =  {8{b1[1]}};
	 assign r3[7:0] =  {8{b1[2]}};
	 assign r4[7:0] =  {8{b1[3]}};
	 assign r5[7:0] =  {8{b1[4]}};
	 assign r6[7:0] =  {8{b1[5]}};
	 assign r7[7:0] =  {8{b1[6]}};
	 assign r8[7:0] =  {8{b1[7]}};
	 
	 assign p0=a1&r1;
	 assign p1=a1&r2;
	 assign p2=a1&r3;
	 assign p3=a1&r4;
	 assign p4=a1&r5;
	 assign p5=a1&r6;
	 assign p6=a1&r7;
	 assign p7=a1&r8;
	
	assign result[0] = p0[0];
	assign {cr[1], s[1]}   = p0[1] + p1[0];
	assign {cr[2], s[2]}   = p0[2] + p1[1] + p2[0];
	assign {cr[3], s[3]}   = p0[3] + p1[2] + p2[1];
	assign {cr[4], s[4]}   = p0[4] + p1[3] + p2[2];
	assign {cr[10], s[10]} = p3[1] + p4[0];
	assign {cr[5], s[5]}   = p0[5] + p1[4] + p2[3];
	assign {cr[11], s[11]} = p3[2] + p4[1] + p5[0];
	assign {cr[6], s[6]}   = p0[6] + p1[5] + p2[4];
	assign {cr[12], s[12]} = p3[3] + p4[2] + p5[1];
	assign {cr[7], s[7]}   = p0[7] + p1[6] + p2[5];
	assign {cr[13], s[13]} = p3[4] + p4[3] + p5[2];
	assign {cr[8], s[8]}   = p1[7] + p2[6];
	assign {cr[14], s[14]} = p3[5] + p4[4] + p5[3];
	assign {cr[9], s[9]}   = p2[7] + p3[6] + p4[5];
	assign {cr[15], s[15]} = p3[7] + p4[6] + p5[5];
	assign {cr[16], s[16]} = p4[7] + p5[6];

	assign result[1] = s[1];
	assign {cr[17], s[17]} = s[2] + cr[1];
	assign {cr[18], s[18]} = s[3] + cr[2] + p3[0];
	assign {cr[19], s[19]} = s[4] + cr[3] + s[10];
	assign {cr[20], s[20]} = s[5] + cr[4] + s[11];
	assign {cr[21], s[21]} = s[6] + cr[5] + s[12];
	assign {cr[22], s[22]} = s[7] + cr[6] + s[13];
	assign {cr[23], s[23]} = s[8] + cr[7] + s[14];
	assign {cr[24], s[24]} = s[9] + cr[8] + cr[14];
	assign {cr[29], s[29]} = cr[9] + p6[4] + p7[3];
	assign {cr[30], s[30]} = cr[15] + p6[5] + p7[4];
	assign {cr[31], s[31]} = p5[7] + p6[6] + p7[5];
	assign {cr[32], s[32]} = p6[7] + p7[6];
	assign {cr[25], s[25]} = p6[0] + cr[11];
	assign {cr[26], s[26]} = cr[12] + p6[1] + p7[0];
	assign {cr[27], s[27]} = cr[13] + p6[2] + p7[1];
	assign {cr[28], s[28]} = p5[4] + p6[3] + p7[2];

	assign result[2] = s[17];
	halfadder a33(s[18], cr[17], s[33], cr[33]);
	halfadder a34(s[19], cr[18], s[34], cr[34]);
	fulladder a35(s[20], cr[19], cr[10], s[35], cr[35]);
	fulladder a36(s[21], cr[20], s[25], s[36], cr[36]);
	fulladder a37(s[22], cr[21], s[26], s[37], cr[37]);
	fulladder a38(s[23], cr[22], s[27], s[38], cr[38]);
	fulladder a39(s[24], cr[23], s[28], s[39], cr[39]);
	fulladder a40(s[15], cr[24], s[29], s[40], cr[40]);
	halfadder a41(s[16], s[30], s[41], cr[41]);
	halfadder a42(cr[16], s[31], s[42], cr[42]);
	
	assign result[3] = s[33];
	halfadder a43(s[34], cr[33], s[43], cr[43]);
	halfadder a44(s[35], cr[34], s[44], cr[44]);
	halfadder a45(s[36], cr[35], s[45], cr[45]);
	fulladder a46(s[37], cr[36], cr[25], s[46], cr[46]);
	fulladder a47(s[38], cr[37], cr[26], s[47], cr[47]);	
	fulladder a48(s[39], cr[38], cr[27], s[48], cr[48]);
	fulladder a49(s[40], cr[39], cr[28], s[49], cr[49]);	
	fulladder a50(s[41], cr[40], cr[29], s[50], cr[50]);	
	fulladder a51(s[42], cr[30], cr[41], s[51], cr[51]);	
	fulladder a52(cr[42], s[32], cr[31], s[52], cr[52]);	
	halfadder a53(p7[7], cr[32], s[53], cr[53]);
	
	assign result[4] = s[43];
	halfadder a54(s[44], cr[43], result[5], cr[54]);
	fulladder a55(s[45], cr[44], cr[54], result[6], cr[55]);	
	fulladder a56(s[46], cr[45], cr[55], result[7], cr[56]);
	fulladder a57(s[47], cr[46], cr[56], result[8], cr[57]);
	fulladder a58(s[48], cr[47], cr[57], result[9], cr[58]);
	fulladder a59(s[49], cr[48], cr[58], result[10], cr[59]);
	fulladder a60(s[50], cr[49], cr[59], result[11], cr[60]);
	fulladder a61(s[51], cr[50], cr[60], result[12], cr[61]);
	fulladder a62(s[52], cr[51], cr[61], result[13], cr[62]);
	fulladder a63(s[53], cr[52], cr[62], result[14], cr[63]);
	assign result[15] = cr[53];
      
	 
endmodule