module rca_4bit (
  input [3:0] a,
  input [3:0] b,
  output [3:0] sum,
  output cout_final,
  input cinbar
);

wire[4:0] cin; 
wire [3:0] cout;
  genvar p;

assign cin[0]=cinbar;
  generate


for (p = 0; p < 4; p = p + 1) 
	begin : raclp
        
      fulladder gate(a[p], b[p], cin[p], sum[p], cout[p]);
      assign cin[p+1]=cout[p];
	
end
assign cout_final = cout[3];

endgenerate

endmodule

module bcd (x,y,c_in,sum,c_out);

input [3:0] x,y;
input c_in;
output [3:0] sum;
output c_out;

wire [3:0] sum_bar;

wire t1, t2;


rca_4bit g1 (x,y,sum_bar,c_out_bar,c_in);

and g2(t1,sum_bar[3],sum_bar[2]);
and g3(t2,sum_bar[3],sum_bar[1]);
or g4(c_out,t1,t2,c_out_bar);



rca_4bit g5 (.a(sum_bar),.b({1'b0,c_out,c_out,1'b0}),.sum(sum),.cinbar(1'b0));

endmodule


