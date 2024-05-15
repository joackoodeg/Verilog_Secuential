`timescale 1ns / 1ps
`default_nettype none
`define DUMPSTR(x) `"x.vcd`"

module T_FF_tb;

    // Parámetros de tiempo
    parameter PERIOD = 10; // Periodo del reloj (en unidades de tiempo)
    
    // Declaración de señales
    reg T;          // Entrada T
    reg clk;        // Reloj
    reg reset;      // Señal de reset
    wire Q;         // Salida Q

    // Instancia del flip-flop T
    T_FF uut (
        .T(T),
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );

    // Generación del reloj
    always #((PERIOD / 2)) clk = ~clk; // Genera un ciclo de reloj de 50% de duty cycle

    // Inicialización de señales
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, T_FF_tb);

        clk = 0;
        reset = 1; // Activa el reset inicialmente
        #100;     // Espera un poco de tiempo
        reset = 0; // Desactiva el reset
        #100;     // Espera un poco de tiempo

        // Prueba de diferentes valores de entrada T
        #10 T = 1; #10 T = 0; #10 T = 1; #10 T = 1; #10 T = 0; #10 T = 1; #10 T = 1; #10 T = 0;
        #100;     // Espera un poco de tiempo

        // Finaliza la simulación
        $finish;
    end

    // Monitorear cambios en las señales
    initial begin
        $monitor("Time=%0t, T=%b, clk=%b, reset=%b, Q=%b", $time, T, clk, reset, Q);
    end

endmodule
