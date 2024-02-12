module rotabit_testbench;

    // Inputs
    reg clk;
    reg rst;

    // Outputs
    wire [15:0] x;

    // Instantiate the DUT
    rotabit dut (
        .clk(clk),
        .rst(rst),
        .x(x)
    );

    // Initialize inputs
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
        rst = 1;
        #10 rst = 0;
    end

    // Generate clock
    always #50 clk = ~clk;

    // Monitor outputs
    always @(posedge clk) begin
        $display("x = %h", x);
    end

    // Dump simulation data to VCD file
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, rotabit_testbench);
        #1000;
        $finish;
    end

endmodule

