
module tb_sumador_serie;

reg [7:0] A, B;
reg clk, rst;
wire [7:0] sum;

sumador_serie dut (.A(A), .B(B), .clk(clk), .rst(rst), .sum(sum));

initial begin
  // initialize inputs
  A = 8'b00001111;
  B = 8'b00000001;
  clk = 1'b0;
  rst = 1'b1;

  // reset
  #10 rst = 1'b0;
  
  // run for 20 clock cycles
  repeat(20) begin
    #10 clk = ~clk;
  end
  
  // finish simulation
  #10 $finish;
end

endmodule