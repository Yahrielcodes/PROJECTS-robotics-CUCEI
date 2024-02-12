module tb_contador;

// Par�metros del reloj
parameter PERIODO_CLK = 10;
parameter MITAD_PERIODO_CLK = PERIODO_CLK / 2;

// Se�ales de entrada
reg clk = 0;
reg rst;

// Se�ales de salida
wire [15:0] count;

// Instanciar el m�dulo de contador
contador dut (
    .clk(clk),
    .rst(rst),
    .count(count)
);

// Generador de reloj
always #(MITAD_PERIODO_CLK) clk = ~clk;

// Establecer se�al de reset inicialmente en 1
initial rst = 1;

// Test bench
initial begin
    // Esperar 5 ciclos de reloj
    #(5 * PERIODO_CLK);

    // Desactivar se�al de reset
    rst = 0;

    // Esperar 20 ciclos de reloj y verificar la salida
    #(20 * PERIODO_CLK);
    $display("Valor de count: %d", count);

    // Esperar 10 ciclos de reloj y volver a verificar la salida
    #(10 * PERIODO_CLK);
    $display("Valor de count: %d", count);

    // Esperar otros 10 ciclos de reloj y volver a verificar la salida
    #(10 * PERIODO_CLK);
    $display("Valor de count: %d", count);

    // Esperar 5 ciclos de reloj y activar la se�al de reset de nuevo
    #(5 * PERIODO_CLK);
    rst = 1;

    // Esperar otros 10 ciclos de reloj y verificar que el contador se reinicia
    #(10 * PERIODO_CLK);
    $display("Valor de count: %d", count);

    // Esperar 20 ciclos de reloj m�s y finalizar la simulaci�n
    #(20 * PERIODO_CLK);
    $finish;
end

endmodule





