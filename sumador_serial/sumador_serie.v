module serial_adder(
  input [7:0] A, B,
  input clk, rst,
  output reg [7:0] sum
);

reg [7:0] sum_reg;

always @(posedge clk or posedge rst) begin
  if (rst) begin
    sum_reg <= 8'b0;
  end else begin
    sum_reg <= sum_reg + {1'b0, A} + {1'b0, B};
  end
end

assign sum = sum_reg;

endmodule
