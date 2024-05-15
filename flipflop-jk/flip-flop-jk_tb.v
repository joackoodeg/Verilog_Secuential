`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1ns / 1ps

module JK_FF_tb;

// Declaración de señales
    reg J;
    reg K;
    reg clk;
    reg reset;
    wire Q;
    wire Q_bar;

// Instancia del módulo JK_FF
    JK_FF uut (
        .J(J),
        .K(K),
        .clk(clk),
        .reset(reset),
        .Q(Q),
        .Q_bar(Q_bar)
    );

// Generación del reloj
    always #5 clk = ~clk;

// Bloque inicial para la simulación
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, JK_FF_tb);

    // Inicialización de señales
        clk = 0;
        reset = 0;
        J = 0;
        K = 0;
    
    // Aplicación de reset
        #10 reset = 1;
        #10 reset = 0;

    // Prueba de diferentes combinaciones de J y K
        #10 J = 0; K = 0; // No change
        #10 J = 0; K = 1; // Reset Q
        #10 J = 1; K = 0; // Set Q
        #10 J = 1; K = 1; // Toggle Q
        #10 J = 0; K = 1; // Reset Q
        #10 J = 1; K = 0; // Set Q
        #10 J = 1; K = 1; // Toggle Q

        // Finalizar simulación
        #50 $finish;
    end

endmodule

/*
#10: El simulador esperará otras 10 unidades de tiempo antes de ejecutar

EJ: #10 reset = 1;
El simulador esperará 10 unidades de tiempo antes de ejecutar la instrucción reset = 1;.

*/

