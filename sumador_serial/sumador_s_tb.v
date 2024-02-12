module sumador_s_tb;


  reg [7:0] a = 8'b00000001;
  reg [7:0] b = 8'b00000001;
  reg cin = 0;
  

  wire [7:0] s;
  wire cout;


  sumador_s uut (
    .a(a), 
    .b(b), 
    .cin(cin), 
    .s(s), 
    .cout(cout)
  );

  initial begin
   
    $display("Ciclo\t A\t B\t Cin\t S\t Cout");
    #10 a = 8'b00010110; b = 8'b00000010;
    #10 a = 8'b01000100; b = 8'b00000111;
    #10 a = 8'b00001001; b = 8'b00101000;
    #10 a = 8'b00010000; b = 8'b00010000;
    #10 a = 8'b00100000; b = 8'b00100100;
    #10 a = 8'b01000000; b = 8'b01000001;
    #10 a = 8'b10001111; b = 8'b10101000;
    #10 $finish;
  end
  
  always @(posedge cout) begin
    $display("%d\t %b\t %b\t %b\t %b\t %b", $time, a, b, cin, s, cout);
    $display("S: %b", s);
  end

endmodule
