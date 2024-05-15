module JK_FF(
    input wire J,
    input wire K,
    input wire clk,
    input wire reset,
    output reg Q
    output reg Q_bar
);
// Asignamos el valor de Q_bar como el complemento de Q
    assign Q_bar = ~Q;

endmodule