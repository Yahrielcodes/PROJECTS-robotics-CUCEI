
module contador(
    input clk, // señal de reloj
    input rst, // señal de reset
    output reg [15:0] count // registro de salida de 16 bits
);

// siempre y cuando la señal de reset sea alta, el contador debe ser cero
always @(posedge clk) begin
    if (rst) begin
        count <= 16'b0;
    end else begin
        count <= count + 1;
    end
end

endmodule