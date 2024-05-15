`timescale 1ns / 1ps
`default_nettype none
`define DUMPSTR(x) `"x.vcd`"

module D_FF_Advanced_tb;

    // Parámetros de tiempo
    parameter PERIOD = 10; // Periodo del reloj (en unidades de tiempo)
    
    // Declaración de señales
    reg D;               // Entrada de datos
    reg clk;             // Reloj
    reg reset_async;     // Reset asincrónico
    reg reset_sync;      // Reset síncrono
    reg enable;          // Señal de habilitación
    wire Q;              // Salida Q

    // Instancia del flip-flop D avanzado
    D_FF_Advanced uut (
        .D(D),
        .clk(clk),
        .reset_async(reset_async),
        .reset_sync(reset_sync),
        .enable(enable),
        .Q(Q)
    );

    // Generación del reloj
    always #((PERIOD / 2)) clk = ~clk; // Genera un ciclo de reloj de 50% de duty cycle

    // Inicialización de señales
    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, D_FF_Advanced_tb);

        clk = 0;
        reset_async = 1; // Activa el reset asincrónico inicialmente
        reset_sync = 1;  // Activa el reset síncrono inicialmente
        enable = 0;      // Desactiva la señal de habilitación inicialmente
        #100;            // Espera un poco de tiempo
        reset_async = 0; // Desactiva el reset asincrónico
        reset_sync = 0;  // Desactiva el reset síncrono
        #100;            // Espera un poco de tiempo

        // Prueba de diferentes valores de entrada D con habilitación desactivada
        #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0;
        #100; // Espera un poco de tiempo

        // Habilita la señal de habilitación
        enable = 1;
        #100; // Espera un poco de tiempo

        // Prueba de diferentes valores de entrada D con habilitación activada
        #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0; #10 D = 1; #10 D = 0;
        #100; // Espera un poco de tiempo

        // Activa el reset síncrono
        reset_sync = 1;
        #10 reset_sync = 0;
        #100; // Espera un poco de tiempo

        // Activa el reset asincrónico
        reset_async = 1;
        #10 reset_async = 0;
        #100; // Espera un poco de tiempo

        // Finaliza la simulación
        $finish;
    end

    // Monitorear cambios en las señales
    initial begin
        $monitor("Time=%0t, D=%b, clk=%b, reset_async=%b, reset_sync=%b, enable=%b, Q=%b", $time, D, clk, reset_async, reset_sync, enable, Q);
    end

endmodule
