`timescale 1ns / 1ps
`default_nettype none
`define DUMPSTR(x) `"x.vcd`"

module D_FF_tb;

    // Parámetros de tiempo
    parameter PERIOD = 10; // Periodo del reloj (en unidades de tiempo)
    
    // Declaración de señales
    reg D;          // Entrada de datos
    reg clk;        // Reloj
    reg reset;      // Señal de reset
    wire Q;         // Salida Q

    // Instancia del flip-flop D
    D_FF uut (
        .D(D),
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    // Generación del reloj
    always #((PERIOD / 2)) clk = ~clk; // Genera un ciclo de reloj de 50% de duty cycle

    // Inicialización de señales
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, D_FF_tb);

        clk = 0;
        reset = 1; // Activa el reset inicialmente
        #100;     // Espera un poco de tiempo
        reset = 0; // Desactiva el reset
        #100;     // Espera un poco de tiempo

        // Prueba de diferentes valores de entrada D
        #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0;
        #100;     // Espera un poco de tiempo

        // Finaliza la simulación
        $finish;
    end

endmodule
